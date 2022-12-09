# Домашнее задание к занятию "6.5. Elasticsearch"

## Задача 1

Так как проблематично скачать сейчас elasticsearch, я просто прокинул в контейнер архив

Dockerfile:

		FROM centos:7

		COPY elasticsearch-8.5.3-linux-x86_64.tar.gz /opt
		COPY elasticsearch-8.5.3-linux-x86_64.tar.gz.sha512 /opt

		RUN groupadd elasticsearch && useradd -c "elasticsearch" -g elasticsearch elasticsearch && \
			mkdir -p /var/lib/elasticsearch/data && \
			chmod -R 777 /var/lib/elasticsearch && \
			yum update -y && \
			yum install java-1.8.0-openjdk.x86_64 -y && \
			yum install perl-Digest-SHA -y

		RUN cd /opt && \
			tar -xzf elasticsearch-8.5.3-linux-x86_64.tar.gz && \
			rm -f elasticsearch-8.5.3-linux-x86_64.tar.gz && \
			chown -R elasticsearch:elasticsearch /opt/elasticsearch-8.5.3

		USER elasticsearch
		WORKDIR /opt/elasticsearch-8.5.3/

		COPY elasticsearch.yml /opt/elasticsearch-8.5.3/config/

		EXPOSE 9200 9300

		CMD ["bin/elasticsearch"]


Ссылка на образ: https://hub.docker.com/r/m222777/elasticsearch

		[elasticsearch@be3389a90c1f elasticsearch-8.5.3]$ curl --insecure -u elastic https://localhost:9200
		Enter host password for user 'elastic':
		{
		  "name" : "netology_test",
		  "cluster_name" : "netology",
		  "cluster_uuid" : "o7GV_CyBTpOK938wMo-VWg",
		  "version" : {
			"number" : "8.5.3",
			"build_flavor" : "default",
			"build_type" : "tar",
			"build_hash" : "4ed5ee9afac63de92ec98f404ccbed7d3ba9584e",
			"build_date" : "2022-12-05T18:22:22.226119656Z",
			"build_snapshot" : false,
			"lucene_version" : "9.4.2",
			"minimum_wire_compatibility_version" : "7.17.0",
			"minimum_index_compatibility_version" : "7.0.0"
		  },
		  "tagline" : "You Know, for Search"
		}

## Задача 2

Ознакомтесь с документацией и добавьте в elasticsearch 3 индекса, в соответствии со таблицей:

		[elasticsearch@4d584070c846 elasticsearch-8.5.3]$ curl -X PUT --insecure -u elastic "https://localhost:9200/ind-1?pretty" -H 'Content-Type: application/json' -d' { "settings": { "index": { "number_of_shards": 1, "number_of_replicas": 0 }}}'
		Enter host password for user 'elastic':
		{
		  "acknowledged" : true,
		  "shards_acknowledged" : true,
		  "index" : "ind-1"
		}
		[elasticsearch@4d584070c846 elasticsearch-8.5.3]$ curl -X PUT --insecure -u elastic "https://localhost:9200/ind-2?pretty" -H 'Content-Type: application/json' -d' { "settings": { "index": { "number_of_shards": 2, "number_of_replicas": 1 }}}'
		Enter host password for user 'elastic':
		{
		  "acknowledged" : true,
		  "shards_acknowledged" : true,
		  "index" : "ind-2"
		}
		[elasticsearch@4d584070c846 elasticsearch-8.5.3]$
		[elasticsearch@4d584070c846 elasticsearch-8.5.3]$ curl -X PUT --insecure -u elastic "https://localhost:9200/ind-3?pretty" -H 'Content-Type: application/json' -d' { "settings": { "index": { "number_of_shards": 4, "number_of_replicas": 2 }}}'
		Enter host password for user 'elastic':
		{
		  "acknowledged" : true,
		  "shards_acknowledged" : true,
		  "index" : "ind-3"
		}

Получите список индексов и их статусов, используя API и приведите в ответе на задание.

	[elasticsearch@4d584070c846 elasticsearch-8.5.3]$ curl -X GET --insecure -u elastic:elastic "https://localhost:9200/_cat/indices?v=true"
	health status index uuid                   pri rep docs.count docs.deleted store.size pri.store.size
	green  open   ind-1 2NUgonlUSWm_ifg8J2lSgA   1   0          0            0       225b           225b
	yellow open   ind-3 2MEhjvh2Sje9-sZgpdu8yA   4   2          0            0       900b           900b
	yellow open   ind-2 cOJlFhb4TViaq9SPpOFHJw   2   1          0            0       450b           450b

Получите состояние кластера elasticsearch, используя API.

	[elasticsearch@4d584070c846 elasticsearch-8.5.3]$ curl -X GET --insecure -u elastic:elastic "https://localhost:9200/_cluster/health?pretty"
	{
	  "cluster_name" : "netology",
	  "status" : "yellow",
	  "timed_out" : false,
	  "number_of_nodes" : 1,
	  "number_of_data_nodes" : 1,
	  "active_primary_shards" : 9,
	  "active_shards" : 9,
	  "relocating_shards" : 0,
	  "initializing_shards" : 0,
	  "unassigned_shards" : 10,
	  "delayed_unassigned_shards" : 0,
	  "number_of_pending_tasks" : 0,
	  "number_of_in_flight_fetch" : 0,
	  "task_max_waiting_in_queue_millis" : 0,
	  "active_shards_percent_as_number" : 47.368421052631575
	}

Желтый статус означает, что все первичные сегменты распределены по узлам, но некоторые реплики — нет, статус указывает на то, что один или несколько сегментов реплики в кластере Elasticsearch не выделены узлу. В кластере только одна нода, реплицировать некуда

Удалите все индексы.

	[elasticsearch@4d584070c846 elasticsearch-8.5.3]$ curl -X DELETE --insecure -u elastic:elastic "https://localhost:9200/ind-1?pretty"
	{
	  "acknowledged" : true
	}
	[elasticsearch@4d584070c846 elasticsearch-8.5.3]$ curl -X DELETE --insecure -u elastic:elastic "https://localhost:9200/ind-2?pretty"
	{
	  "acknowledged" : true
	}
	[elasticsearch@4d584070c846 elasticsearch-8.5.3]$ curl -X DELETE --insecure -u elastic:elastic "https://localhost:9200/ind-3?pretty"
	{
	  "acknowledged" : true
	}

## Задача 3


