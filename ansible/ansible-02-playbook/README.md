## Домашнее задание к занятию "2. Работа с Playbook"

Плейбук устанавливает Clickhouse и Vector на хосты, указанные в inventory файле. 

В переменных group_vars созданы 2 папки с файлами которые содержат список переменных для обоих серверов по отдельности

      /group_vars/clickhouse/clickhouse.yml
      clickhouse_version - версия пакета Clickhouse
      clickhouse_packages - список rpm пакетов

      /group_vars/vector/vector.yml
      vector_version - версия пакета Vector

inventori состоит из 2х групп хостов 

Плейбук состоит из нескольких блоков. В записаны таски, которые скачивают rmp пакеты clickhouse

Список тасок и что они делают 

      name: Get clickhouse distrib - скачивают пакеты clickhouse
      name: Install clickhouse packages - устанавливают пакеты с помощью yum (disable_gpg_check: true - потому что отваливается с ошибкой проверки GPG)
      name: Flush handlers - нужен для старта сервиса clickhouse-server
      name: Create database - создает БД logs 
      name: Get vector distrib - скачивает пакет vector
      name: Install vector packages - устанавливает пакет vector (disable_gpg_check: true - потому что отваливается с ошибкой проверки GPG)
      name: Create vector config file - передает файл конфига Vector на сервер vector в папку /etc/vector/
      name: Vector systemd unit - создает юнит для службы векта и указывает где лежит файл конфига после чего перезапускается vector
      name: systemctl daemon-reload - перезапуск служб
      
В teamplates созданы файл конфига и юнита для Vector
