    # ansible --version
    ansible [core 2.12.7]
      config file = /etc/ansible/ansible.cfg
      configured module search path = ['/root/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
      ansible python module location = /usr/lib/python3.8/site-packages/ansible
      ansible collection location = /root/.ansible/collections:/usr/share/ansible/collections
      executable location = /usr/bin/ansible
      python version = 3.8.13 (default, Jun 24 2022, 15:27:57) [GCC 8.5.0 20210514 (Red Hat 8.5.0-13)]
      jinja version = 2.11.3
      libyaml = True

1) 

      TASK [Print fact] ************************************************************************
      ok: [localhost] => {
          "msg": 12
      }

2) 

    # cat group_vars/all/examp.yml
    ---
      some_fact: all default fact

3)

4)

        [root@localhost playbook]# docker ps
        CONTAINER ID   IMAGE                 COMMAND            CREATED         STATUS         PORTS     NAMES
        596cc9ef81be   pycontribs/centos:7   "sleep infinity"   4 minutes ago   Up 4 minutes             centos7
        58ea6aba9bcf   pycontribs/ubuntu     "sleep infinity"   4 minutes ago   Up 4 minutes             ubuntu
        [root@localhost playbook]# ansible-playbook site.yml -i inventory/prod.yml

        PLAY [Print os facts] ***************************************************************************************************

        TASK [Gathering Facts] **************************************************************************************************
        ok: [ubuntu]
        ok: [centos7]

        TASK [Print OS] *********************************************************************************************************
        ok: [centos7] => {
            "msg": "CentOS"
        }
        ok: [ubuntu] => {
            "msg": "Ubuntu"
        }

        TASK [Print fact] ***********************************************************************************************
        ok: [centos7] => {
            "msg": "el"
        }
        ok: [ubuntu] => {
            "msg": "deb"
        }

        PLAY RECAP ***************************************************************************************************
        centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
        ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
        
5)

        [root@localhost playbook]# cat group_vars/deb/examp.yml
        ---
          some_fact: "deb default fact"
        [root@localhost playbook]# cat group_vars/el/examp.yml
        ---
          some_fact: "el default fact"
        [root@localhost playbook]#

6)

        TASK [Print fact] ********************************************************************************
        ok: [centos7] => {
            "msg": "el default fact"
        }
        ok: [ubuntu] => {
            "msg": "deb default fact"
        }

7) 

        [root@localhost playbook]# ansible-vault encrypt group_vars/deb/examp.yml
        New Vault password:
        Confirm New Vault password:
        Encryption successful
        [root@localhost playbook]# ansible-vault encrypt group_vars/el/examp.yml
        New Vault password:
        Confirm New Vault password:
        Encryption successful
        
8) 

        [root@localhost playbook]# ansible-playbook site.yml -i inventory/prod.yml --ask-vault-pass
        Vault password:

        PLAY [Print os facts] *******************************************

        TASK [Gathering Facts] *********************************
        ok: [ubuntu]
        ok: [centos7]

        TASK [Print OS] ******************************************
        ok: [centos7] => {
            "msg": "CentOS"
        }
        ok: [ubuntu] => {
            "msg": "Ubuntu"
        }

        TASK [Print fact] ************************************
        ok: [centos7] => {
            "msg": "el default fact"
        }
        ok: [ubuntu] => {
            "msg": "deb default fact"
        }

        PLAY RECAP **************************************************
        centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
        ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

9) 

      ansible-doc -t connection local
      > ANSIBLE.BUILTIN.LOCAL    (/usr/lib/python3.8/site-packages/ansible/plugins/connection/local.py)

              This connection plugin allows ansible to execute tasks on the Ansible 'controller' instead of on a remote host.

10)

      ---
        el:
          hosts:
            centos7:
              ansible_connection: docker
        deb:
          hosts:
            ubuntu:
              ansible_connection: docker

        local:
          hosts:
            localhost:
              ansible_connection: local

11)

        [root@localhost playbook]# ansible-playbook site.yml -i inventory/prod.yml --ask-vault-pass
        Vault password:

        PLAY [Print os facts] *************************************************************************************

        TASK [Gathering Facts] ************************************************************************************
        ok: [ubuntu]
        ok: [localhost]
        ok: [centos7]

        TASK [Print OS] *******************************************************************************************
        ok: [localhost] => {
            "msg": "CentOS"
        }
        ok: [centos7] => {
            "msg": "CentOS"
        }
        ok: [ubuntu] => {
            "msg": "Ubuntu"
        }

        TASK [Print fact] *********************************************************************************************
        ok: [localhost] => {
            "msg": "all default fact"
        }
        ok: [ubuntu] => {
            "msg": "deb default fact"
        }
        ok: [centos7] => {
            "msg": "el default fact"
        }

        PLAY RECAP ****************************************************************************************************************
        centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
        localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
        ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0


