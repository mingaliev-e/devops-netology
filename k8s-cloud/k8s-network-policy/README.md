# Домашнее задание к занятию «Как работает сеть в K8s»

### Цель задания

Настроить сетевую политику доступа к подам.

### Чеклист готовности к домашнему заданию

1. Кластер K8s с установленным сетевым плагином Calico.

### Инструменты и дополнительные материалы, которые пригодятся для выполнения задания

1. [Документация Calico](https://www.tigera.io/project-calico/).
2. [Network Policy](https://kubernetes.io/docs/concepts/services-networking/network-policies/).
3. [About Network Policy](https://docs.projectcalico.org/about/about-network-policy).

-----

### Задание 1. Создать сетевую политику или несколько политик для обеспечения доступа

1. Создать deployment'ы приложений frontend, backend и cache и соответсвующие сервисы.
2. В качестве образа использовать network-multitool.
3. Разместить поды в namespace App.
4. Создать политики, чтобы обеспечить доступ frontend -> backend -> cache. Другие виды подключений должны быть запрещены.
5. Продемонстрировать, что трафик разрешён и запрещён.

1) Создаем кластер K8S с помощью kubespray

![image](https://github.com/mingaliev-e/devops-netology/assets/111060072/97c15559-83a7-4a64-a3e3-dddec0c61046)

![image](https://github.com/mingaliev-e/devops-netology/assets/111060072/5235b92e-4786-4203-8e56-387f1169a200)

2) Создаем Namespace App

-----
    admincm@kubespray1:~$ sudo kubectl create ns app
    namespace/app created

3) Поднимаем поды

![image](https://github.com/mingaliev-e/devops-netology/assets/111060072/9aa9d380-1ddd-4e9b-8b64-7bc34ad7afb8)

4) Создаем политики 

![image](https://github.com/mingaliev-e/devops-netology/assets/111060072/c7d0bed5-99aa-482a-9e28-4fc284b5d59f)

5) Проверяем 

-----
    frontend --> backend = OK
    frontend --> = X

![image](https://github.com/mingaliev-e/devops-netology/assets/111060072/0e497fa6-6ccc-4312-a40f-bffc29f523f2)

-----
    backend --> frontend = X
    backend --> cache = OK

![image](https://github.com/mingaliev-e/devops-netology/assets/111060072/aea31ee4-3be9-4dba-9d97-c83dd587e3bd)

-----
    cache --> frontend = X
    cache --> backend = X

![image](https://github.com/mingaliev-e/devops-netology/assets/111060072/c5f608b4-17b5-42fd-b24c-76bd167e4876)