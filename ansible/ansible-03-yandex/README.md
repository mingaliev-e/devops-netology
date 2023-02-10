## Домашнее задание к занятию "3. Использование Yandex Cloud"
Плейбук устанавливает Clickhouse, Vector и Lighthouse на хосты, указанные в inventory файле. 

В директории group_vars созданы 3 папки с файлами которые содержат список переменных для обоих серверов по отдельности

| Name | Default Value | Description |
|:-----|:--------------|:------------|
| *{{ clickhouse_version }}* | 22.3.3.44                 | Clickhouse package version |
| *{{clickhouse_packages }}* | clickhouse-client         | List of installed packages |
|                            | clickhouse-server         |                            |
|                            | clickhouse-common-static  |                            |
| *{{vector_version}}*       | 0.27.0                    | Vector package version     |
| *{{lighthouse_url}}* |https://github.com/VKCOM/lighthouse.git  | link to git repository |
| *{{lighthouse_dir}}* | /usr/share/nginx/html/lighthouse | directory where to download repository files |
| *{{lighthouse_nginx_user}}* | root | nginx user |

inventori list

      ---

      clickhouse:
        hosts:
          clickhouse-01:
            ansible_host: 
            ansible_user: 

      vector:
        hosts:
          vector-01:
            ansible_host: 
            ansible_user: 

      lighthouse:
        hosts:
          lighthouse-01:
            ansible_host: 
            ansible_user: 

Плейбук состоит из нескольких блоков. В них записаны таски, которые скачивают rmp пакеты clickhouse

Tasks list 

| Task | Description |
|:-----|:------------|
| Get clickhouse distrib | скачивают пакеты clickhouse |
| Install clickhouse packages | устанавливают пакеты с помощью yum (disable_gpg_check: true - потому что отваливается с ошибкой проверки GPG) |
| Flush handlers | Старт сервиса clickhouse-server |
| Create database | создает БД logs |
| Get vector distrib | скачивает пакет vector |
| Install vector packages | устанавливает пакет vector (disable_gpg_check: true - потому что отваливается с ошибкой проверки GPG) |
| Create vector config file | передает файл конфига Vector на сервер vector в папку /etc/vector/ |
| Vector systemd unit | создает юнит для службы векта и указывает где лежит файл конфига после чего перезапускается vector |
| systemctl daemon-reload | перезапуск служб |
| Install epel-release | установить пакеты epel-release |
| Install nginx | установит Nginx |
| Create nginx config | создаст файл конфигурации из шаблона |
| Lighthouse Install git | установит git |
| Lighthouse Clone repository | склонирует репозиторий в директорию |
| Create Lighthouse config | создаст файл конфигурации из шаблона |

В teamplates созданы файл конфига и юнита для Vector и Lighthouse


| teamplate | Description |
|:----------|:------------|
| vector.yml.j2 | Vector config file |
| vector.service.j2 | Systemd Unit configuration file |
| lighthouse_nginx.conf.j2 | Lighthouse configuration |
| nginx.conf.j2 | Nginx configuration |

## Параметры плейбука


| Parameter | Deskription |
|:-----|:-------|
| name | Наименование Play |
| hosts | список хостов, на которых нужно выполнить плейбук |
| handlers | обработчик событий, запускаются если какой то task обратился к ним(в нашем случае запуск различных служб) |
| pre_tasks | список tasks, которые нужно выполнить в первую очередь, до выполнения основных tasks |
| tasks | основной набор действий, которые должны быть выполнены на хостах |
      
Тегов в данном плейбуке нет, но теги нужны для того чтоб можног было пометить какой то task, и при необходимости выполнить только эту task, все остальные выполняться не будут.

## Вывод плейбука:

      [root@localhost playbook]# ansible-playbook site2.yml -i inventory/prod.yml
      
      PLAY [Install Clickhouse] *******************************************************************************************************************************
      
      TASK [Gathering Facts] **********************************************************************************************************************************
      ok: [clickhouse-01]
      
      TASK [Get clickhouse distrib] ****************************************************************************************************************************
      changed: [clickhouse-01] => (item=clickhouse-client)
      changed: [clickhouse-01] => (item=clickhouse-server)
      failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "item": "clickhouse-common-static", 
      "msg": "Request failed", "response": "HTTP Error 404: Not Found", "status_code": 404, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}
      
      TASK [Get clickhouse distrib] ******************************************************************************************************************************
      changed: [clickhouse-01]
      
      TASK [Install clickhouse packages] **************************************************************************************************************************
      changed: [clickhouse-01]
      
      TASK [Flush handlers] ***************************************************************************************************************************************
      
      RUNNING HANDLER [Start clickhouse service] ******************************************************************************************************************
      changed: [clickhouse-01]
      
      TASK [Create database] **************************************************************************************************************************************
      changed: [clickhouse-01]
      
      PLAY [Install Vector] ****************************************************************************************************************************************
      
      TASK [Gathering Facts] ***************************************************************************************************************************************
      ok: [vector-01]
      
      TASK [Get vector distrib] ************************************************************************************************************************************
      changed: [vector-01]
      
      TASK [Install vector packages] *****************************************************************************************************************************
      changed: [vector-01]
      
      TASK [Create vector config file] ****************************************************************************************************************************
      changed: [vector-01]
      
      TASK [Vector systemd unit] *************************************************************************************************************************************
      changed: [vector-01]
      
      RUNNING HANDLER [Start Vector service] *************************************************************************************************************************
      changed: [vector-01]
      
      PLAY [Install NGINX] **************************************************************************************************************************************
      
      TASK [Gathering Facts] ***************************************************************************************************************************************
      ok: [lighthouse-01]
      
      TASK [Install epel-release] ************************************************************************************************************************************
      changed: [lighthouse-01]
      
      TASK [Install nginx] *******************************************************************************************************************************************
      changed: [lighthouse-01]
      
      TASK [Create nginx config] *************************************************************************************************************************************
      changed: [lighthouse-01]
      
      RUNNING HANDLER [Nginx start] ****************************************************************************************************************************
      changed: [lighthouse-01]
      
      RUNNING HANDLER [Nginx reload] ****************************************************************************************************************************
      changed: [lighthouse-01]
      
      PLAY [Install lighthouse] ****************************************************************************************************************************************
      
      TASK [Gathering Facts] ***************************************************************************************************************************
      ok: [lighthouse-01]
      
      TASK [Lighthouse | Install git] ***************************************************************************************************************************
      changed: [lighthouse-01]
      
      TASK [Lighthouse | Clone repository] ***************************************************************************************************************************
      changed: [lighthouse-01]
      
      TASK [Create Lighthouse config] ******************************************************************************************************************************
      changed: [lighthouse-01]
      
      RUNNING HANDLER [Nginx reload] *******************************************************************************************************************************
      changed: [lighthouse-01]
      
      PLAY RECAP ****************************************************************************************************************************************************
      clickhouse-01              : ok=5    changed=4    unreachable=0    failed=0    skipped=0    rescued=1    ignored=0
      lighthouse-01              : ok=11   changed=9    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
      vector-01                  : ok=6    changed=5    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
      
