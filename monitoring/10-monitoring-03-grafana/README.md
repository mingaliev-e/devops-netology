# Домашнее задание к занятию 14 «Средство визуализации Grafana»

## Задание 1

Пробросил порты Prometheus и node exporter в docker-compose

Подключил даттасорс

![image](https://user-images.githubusercontent.com/111060072/227794731-f87010cb-ea24-43a8-b9a6-1cf585580d84.png)

## Задание 2

Создайте Dashboard и в ней создайте Panels:

утилизация CPU для nodeexporter (в процентах, 100-idle);

CPULA 1/5/15;

количество свободной оперативной памяти;

количество места на файловой системе.

Для решения этого задания приведите promql-запросы для выдачи этих метрик, а также скриншот получившейся Dashboard.

![image](https://user-images.githubusercontent.com/111060072/227798294-881d7e50-4555-4643-9672-f5a772958d88.png)

CPU util

    100 - (avg by (instance) (rate(node_cpu_seconds_total{job="nodeexporter",mode="idle"}[1m])) * 100)
  
CPU LA 1/5/15

    avg(node_load1{instance="nodeexporter:9100",job="nodeexporter"}) /  count(count(node_cpu_seconds_total{instance="nodeexporter:9100",job="nodeexporter"}) by (cpu)) * 100
    avg(node_load5{instance="nodeexporter:9100",job="nodeexporter"}) /  count(count(node_cpu_seconds_total{instance="nodeexporter:9100",job="nodeexporter"}) by (cpu)) * 100
    avg(node_load15{instance="nodeexporter:9100",job="nodeexporter"}) /  count(count(node_cpu_seconds_total{instance="nodeexporter:9100",job="nodeexporter"}) by (cpu)) * 100
  
Free RAM

    (node_memory_MemFree_bytes{instance="nodeexporter:9100",job="nodeexporter"})
    
Free space on the FS.

    100 - (100 * ((node_filesystem_avail_bytes{instance="nodeexporter:9100",mountpoint="/",fstype!="rootfs"} )  / (node_filesystem_size_bytes{instance="nodeexporter:9100", mountpoint="/",fstype!="rootfs"}) ))
    
## Задание 3

Алерты расставил просто рандомно, чтоб показать, что понял как настраивать

![image](https://user-images.githubusercontent.com/111060072/227800383-5a46b0a8-e423-40eb-bd7e-2bc2aea959be.png)

## Задание 4

JSON приложил в файлах

