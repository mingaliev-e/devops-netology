# Домашнее задание к занятию 10 «Jenkins»

## Создал два VM: для jenkins-master и jenkins-agent.

![image](https://user-images.githubusercontent.com/111060072/225729834-a363edcf-8ede-411f-89e3-557d3f228299.png)

## Установил Jenkins при помощи playbook.

![image](https://user-images.githubusercontent.com/111060072/225729936-64ce5c0f-1ea4-497b-b0c7-00836119096b.png)

## Сделал первоначальную настройку

![image](https://user-images.githubusercontent.com/111060072/225731041-6900b1d2-b47f-4e37-ade5-0a06875213f3.png)

Спустя миллиард попыток...

![image](https://user-images.githubusercontent.com/111060072/225755432-f81a52d5-6e6a-4c24-ac90-9a0adad9b264.png)

      TASK [Wait for instance(s) deletion to complete] *******************************
      FAILED - RETRYING: Wait for instance(s) deletion to complete (300 retries left).
      changed: [localhost] => (item=Ubuntu_latest)

      TASK [Delete docker networks(s)] ***********************************************

      PLAY RECAP *********************************************************************
      localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

      INFO     Pruning extra files from scenario ephemeral directory
      Finished: SUCCESS
      
## Сделал Declarative Pipeline Job, который будет запускать molecule test из любого вашего репозитория с ролью.

![image](https://user-images.githubusercontent.com/111060072/225758400-4a076d92-c59c-4521-868c-f2a605b9b473.png)

![image](https://user-images.githubusercontent.com/111060072/225758737-f6253abc-94c5-4446-8428-f25096eb0436.png)

![image](https://user-images.githubusercontent.com/111060072/225758855-c901f0f8-a18d-4779-ad36-c23ea8000c23.png)

## Создал Multibranch Pipeline на запуск Jenkinsfile из репозитория.

![image](https://user-images.githubusercontent.com/111060072/225854968-cd05a2f0-2608-4a7b-b61e-d55f310f95f9.png)
![image](https://user-images.githubusercontent.com/111060072/225855041-3dd0c6ef-a30f-4cd9-8321-2c8ee1762bef.png)
![image](https://user-images.githubusercontent.com/111060072/225855113-e66ae4e6-188a-4e29-8227-7d32b406285d.png)
![image](https://user-images.githubusercontent.com/111060072/225855224-f666c513-1fab-4215-9880-bfdaa139a669.png)
![image](https://user-images.githubusercontent.com/111060072/225855277-29af4c5c-3a07-4c5f-93d4-2deb6b7ce1b5.png)

## Создал Scripted Pipeline, наполнить его скриптом из pipeline.

![image](https://user-images.githubusercontent.com/111060072/225878426-202611d0-0d49-410b-bedc-0b9d902e7b92.png)

Если False то запускается с флагами --check --diff 

![image](https://user-images.githubusercontent.com/111060072/225878679-3cb8c3c9-5468-4c96-a33d-f69585bdd592.png)

Если True

![image](https://user-images.githubusercontent.com/111060072/225878884-62252975-bc94-4e4a-ade1-aaab2e7d5d30.png)

![image](https://user-images.githubusercontent.com/111060072/225878960-e8a33e67-7817-45b8-94f2-fc97a3dd0ea2.png)


