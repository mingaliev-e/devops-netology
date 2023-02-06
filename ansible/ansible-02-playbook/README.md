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

## Параметры плейбука

      name: Наименование Play
      hosts: список хостов, на которых нужно выполнить плейбук
      handlers: обработчик событий, запускаются если какой то task обратился к ним(в нашем случае запуск различных служб)
      tasks: основной набор действий, которые должны быть выполнены на хостах
      
      Тегов в данном плейбуке нет, но теги нужны для того чтоб можног было пометить какой то task, и при необходимости выполнить только эту task, все остальные выполняться не будут.

## Вывод плейбука:

      [root@localhost playbook]# ansible-playbook -i inventory/prod.yml site.yml
      
      PLAY [Install Clickhouse] ******************************************************************************************************************************************
      
      TASK [Gathering Facts] *********************************************************************************************************************************************
      ok: [clickhouse-01]
      
      TASK [Get clickhouse distrib] ***************************************************************************************************************************************
      changed: [clickhouse-01] => (item=clickhouse-client)
      changed: [clickhouse-01] => (item=clickhouse-server)
      failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "item": "clickhouse-common-static", 
      "msg": "Request failed", "response": "HTTP Error 404: Not Found", "status_code": 404, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}
      
      TASK [Get clickhouse distrib] **************************************************************************************************************************************
      changed: [clickhouse-01]
      
      TASK [Install clickhouse packages] *********************************************************************************************************************************
      changed: [clickhouse-01]
      
      TASK [Flush handlers] **********************************************************************************************************************************************
      
      RUNNING HANDLER [Start clickhouse service] **********************************************************************************************************************
      changed: [clickhouse-01]
      
      TASK [Create database] *****************************************************************************************************************************************
      changed: [clickhouse-01]
      
      PLAY [Install Vector] *********************************************************************************************************************************************
      
      TASK [Gathering Facts] *********************************************************************************************************************************************
      ok: [vector-01]
      
      TASK [Get vector distrib] *********************************************************************************************************************************************
      changed: [vector-01]
      
      TASK [Install vector packages] *****************************************************************************************************************************************
      changed: [vector-01]
      
      TASK [Create vector config file] ****************************************************************************************************************************************
      changed: [vector-01]
      
      TASK [Vector systemd unit] ***********************************************************************************************************************************************
      changed: [vector-01]
      
      RUNNING HANDLER [Start Vector service] ***********************************************************************************************************************************
      changed: [vector-01]
      
      PLAY RECAP ***************************************************************************************************************************************************************
      clickhouse-01              : ok=5    changed=4    unreachable=0    failed=0    skipped=0    rescued=1    ignored=0
      vector-01                  : ok=6    changed=5    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
      
