# Домашнее задание к занятию "4. Работа с roles"

Ссылка на роль Vector 

https://github.com/mingaliev-e/vector-role

Ссылка на роль Lighthouse

https://github.com/mingaliev-e/lighthouse-role

Создал какталоги с помощью ansible-galaxy role init

Раскидал все tasks, handlers, templates и переменные по ролям 

## Вывод плейбука

      [root@localhost test3]# ansible-playbook site2.yml -i inventory/prod.yml
      
      PLAY [Install Clickhouse] ****************************************************************************************************
      
      TASK [Gathering Facts] ******************************************************************************************************
      ok: [clickhouse-01]
      
      TASK [clickhouse : Include OS Family Specific Variables] *******************************************************************
      ok: [clickhouse-01]
      
      TASK [clickhouse : include_tasks] *****************************************************************************************
      included: /etc/ansible/test3/roles/clickhouse/tasks/precheck.yml for clickhouse-01
      
      TASK [clickhouse : Requirements check | Checking sse4_2 support] *********************************************************
      ok: [clickhouse-01]
      
      TASK [clickhouse : Requirements check | Not supported distribution && release] ******************************************
      skipping: [clickhouse-01]
      
      TASK [clickhouse : include_tasks] **************************************************************************************
      included: /etc/ansible/test3/roles/clickhouse/tasks/params.yml for clickhouse-01
      
      TASK [clickhouse : Set clickhouse_service_enable] *********************************************************************
      ok: [clickhouse-01]
      
      TASK [clickhouse : Set clickhouse_service_ensure] ****************************************************************************
      ok: [clickhouse-01]
      
      TASK [clickhouse : include_tasks] *******************************************************************************************
      included: /etc/ansible/test3/roles/clickhouse/tasks/install/apt.yml for clickhouse-01
      
      TASK [clickhouse : Install by APT | Apt-key add repo key] **********************************************************************
      changed: [clickhouse-01]
      
      TASK [clickhouse : Install by APT | Remove old repo] **************************************************************************
      ok: [clickhouse-01]
      
      TASK [clickhouse : Install by APT | Repo installation] ***********************************************************************
      changed: [clickhouse-01]
      
      TASK [clickhouse : Install by APT | Package installation] *******************************************************************
      skipping: [clickhouse-01]
      
      TASK [clickhouse : Install by APT | Package installation] ******************************************************************
      changed: [clickhouse-01]
      
      TASK [clickhouse : Hold specified version during APT upgrade | Package installation] **************************************
      changed: [clickhouse-01] => (item=clickhouse-client)
      changed: [clickhouse-01] => (item=clickhouse-server)
      changed: [clickhouse-01] => (item=clickhouse-common-static)
      
      TASK [clickhouse : include_tasks] ****************************************************************************************
      included: /etc/ansible/test3/roles/clickhouse/tasks/configure/sys.yml for clickhouse-01
      
      TASK [clickhouse : Check clickhouse config, data and logs] **************************************************************
      ok: [clickhouse-01] => (item=/var/log/clickhouse-server)
      changed: [clickhouse-01] => (item=/etc/clickhouse-server)
      changed: [clickhouse-01] => (item=/var/lib/clickhouse/tmp/)
      changed: [clickhouse-01] => (item=/var/lib/clickhouse/)
      
      TASK [clickhouse : Config | Create config.d folder] ********************************************************************
      changed: [clickhouse-01]
      
      TASK [clickhouse : Config | Create users.d folder] ********************************************************************
      changed: [clickhouse-01]
      
      TASK [clickhouse : Config | Generate system config] ******************************************************************
      changed: [clickhouse-01]
      
      TASK [clickhouse : Config | Generate users config] ******************************************************************
      changed: [clickhouse-01]
      
      TASK [clickhouse : Config | Generate remote_servers config] ********************************************************
      skipping: [clickhouse-01]
      
      TASK [clickhouse : Config | Generate macros config] ***************************************************************
      skipping: [clickhouse-01]
      
      TASK [clickhouse : Config | Generate zookeeper servers config] ***************************************************
      skipping: [clickhouse-01]
      
      TASK [clickhouse : Config | Fix interserver_http_port and intersever_https_port collision] **********************
      skipping: [clickhouse-01]
      
      TASK [clickhouse : Notify Handlers Now] ************************************************************************
      
      RUNNING HANDLER [clickhouse : Restart Clickhouse Service] ********************************************************************
      ok: [clickhouse-01]
      
      TASK [clickhouse : include_tasks] *******************************************************************************************
      included: /etc/ansible/test3/roles/clickhouse/tasks/service.yml for clickhouse-01
      
      TASK [clickhouse : Ensure clickhouse-server.service is enabled: True and state: restarted] *********************************
      changed: [clickhouse-01]
      
      TASK [clickhouse : Wait for Clickhouse Server to Become Ready] ************************************************************
      ok: [clickhouse-01]
      
      TASK [clickhouse : include_tasks] ****************************************************************************************
      included: /etc/ansible/test3/roles/clickhouse/tasks/configure/db.yml for clickhouse-01
      
      TASK [clickhouse : Set ClickHose Connection String] *********************************************************************
      ok: [clickhouse-01]
      
      TASK [clickhouse : Gather list of existing databases] ******************************************************************
      ok: [clickhouse-01]
      
      TASK [clickhouse : Config | Delete database config] *******************************************************************
      
      TASK [clickhouse : Config | Create database config] ******************************************************************
      
      TASK [clickhouse : include_tasks] ***********************************************************************************
      included: /etc/ansible/test3/roles/clickhouse/tasks/configure/dict.yml for clickhouse-01
      
      TASK [clickhouse : Config | Generate dictionary config] ************************************************************
      skipping: [clickhouse-01]
      
      TASK [clickhouse : include_tasks] *********************************************************************************
      skipping: [clickhouse-01]
      
      PLAY [Install Vector] ********************************************************************************************
      
      TASK [Gathering Facts] ****************************************************************************************************
      ok: [vector-01]
      
      TASK [vector : Get vector distrib] ***************************************************************************************
      ok: [vector-01]
      
      TASK [vector : Install vector packages] *********************************************************************************
      ok: [vector-01]
      
      TASK [vector : Create vector config file] ******************************************************************************
      ok: [vector-01]
      
      TASK [vector : Vector systemd unit] ***********************************************************************************
      ok: [vector-01]
      
      PLAY [Install lighthouse and Nginx] **********************************************************************************
      
      TASK [Gathering Facts] **********************************************************************************************
      ok: [lighthouse-01]
      
      TASK [Lighthouse | Install git] ************************************************************************************
      ok: [lighthouse-01]
      
      TASK [lighthouse : Install epel-release] **************************************************************************
      ok: [lighthouse-01]
      
      TASK [lighthouse : Install nginx] ********************************************************************************
      ok: [lighthouse-01]
      
      TASK [lighthouse : Create nginx config] *************************************************************************
      ok: [lighthouse-01]
      
      TASK [lighthouse : Lighthouse | Clone repository] **************************************************************
      ok: [lighthouse-01]
      
      TASK [lighthouse : Create Lighthouse config] ******************************************************************
      ok: [lighthouse-01]
      
      PLAY RECAP ***************************************************************************************************
      clickhouse-01              : ok=27   changed=10   unreachable=0    failed=0    skipped=10   rescued=0    ignored=0
      lighthouse-01              : ok=7    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
      vector-01                  : ok=5    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
     

 
