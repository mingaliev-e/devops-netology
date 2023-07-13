# Домашнее задание к занятию «Хранение в K8s. Часть 2»

### Дополнительные материалы для выполнения задания

1. [Инструкция по установке NFS в MicroK8S](https://microk8s.io/docs/nfs). 
2. [Описание Persistent Volumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/). 
3. [Описание динамического провижининга](https://kubernetes.io/docs/concepts/storage/dynamic-provisioning/). 
4. [Описание Multitool](https://github.com/wbitt/Network-MultiTool).

### Задание 1

Создать Deployment приложения, использующего локальный PV, созданный вручную.

1. Создать Deployment приложения, состоящего из контейнеров busybox и multitool.
2. Создать PV и PVC для подключения папки на локальной ноде, которая будет использована в поде.

    ![image](https://github.com/mingaliev-e/devops-netology/assets/111060072/04a980ae-6dbd-47df-9907-4b644403034e)

3. Продемонстрировать, что multitool может читать файл, в который busybox пишет каждые пять секунд в общей директории.

    ![image](https://github.com/mingaliev-e/devops-netology/assets/111060072/7312934e-439e-4b58-8b4a-ca5437c138df)

4. Удалить Deployment и PVC. Продемонстрировать, что после этого произошло с PV. Пояснить, почему.

    ![image](https://github.com/mingaliev-e/devops-netology/assets/111060072/c306da3f-fbbf-427f-a54f-d041064d7ac8)
    
    Статус Released говорит о том, что к данному PV ранее был привязан какой-то PVC и в нем остались данные 
    и данный PV недоступен для подключеия к другим pvc пока PV не будет освобожден администратором 
    (освободить можно через kubectl edit pv pv-name удалив блок "claimRef")

5. Продемонстрировать, что файл сохранился на локальном диске ноды. Удалить PV.  Продемонстрировать что произошло с файлом после удаления PV. Пояснить, почему.
6. Предоставить манифесты, а также скриншоты или вывод необходимых команд.

    ![image](https://github.com/mingaliev-e/devops-netology/assets/111060072/4e2af104-d937-48fd-b1eb-d1c632c9e4a0)
    
    ![image](https://github.com/mingaliev-e/devops-netology/assets/111060072/bc5a6dd3-2327-4759-b4af-8448e1fe0cb8)

    После удаления PV файл с данными по прежнему остается на ноде

------

### Задание 2

Создать Deployment приложения, которое может хранить файлы на NFS с динамическим созданием PV.

1. Включить и настроить NFS-сервер на MicroK8S.

    Настроил по инструкции 
    ![image](https://github.com/mingaliev-e/devops-netology/assets/111060072/9d57f81d-40a6-4da5-bdc0-1795100b6df3)

2. Создать Deployment приложения состоящего из multitool, и подключить к нему PV, созданный автоматически на сервере NFS.

    ![image](https://github.com/mingaliev-e/devops-netology/assets/111060072/c32d85c6-3b94-48fa-b9a8-2db45d941732)

3. Продемонстрировать возможность чтения и записи файла изнутри пода. 

    ![image](https://github.com/mingaliev-e/devops-netology/assets/111060072/539be398-8a29-485d-8877-54bde620a1ee)

4. Предоставить манифесты, а также скриншоты или вывод необходимых команд.

------