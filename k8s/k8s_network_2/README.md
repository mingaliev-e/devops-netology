# Домашнее задание к занятию «Сетевое взаимодействие в K8S. Часть 2»


### Задание 1. Создать Deployment приложений backend и frontend

1. Создать Deployment приложения _frontend_ из образа nginx с количеством реплик 3 шт.
2. Создать Deployment приложения _backend_ из образа multitool. 
3. Добавить Service, которые обеспечат доступ к обоим приложениям внутри кластера. 

![image](https://github.com/mingaliev-e/devops-netology/assets/111060072/6853a499-035c-4464-9c19-2a2efe7bedd4)

4. Продемонстрировать, что приложения видят друг друга с помощью Service.

![image](https://github.com/mingaliev-e/devops-netology/assets/111060072/91e759a4-e115-4483-89c2-532d4b59c154)

![image](https://github.com/mingaliev-e/devops-netology/assets/111060072/8fd3abbe-086d-4f5d-9c3a-f6262479f008)

5. Предоставить манифесты Deployment и Service в решении, а также скриншоты или вывод команды п.4.


### Задание 2. Создать Ingress и обеспечить доступ к приложениям снаружи кластера

1. Включить Ingress-controller в MicroK8S.
2. Создать Ingress, обеспечивающий доступ снаружи по IP-адресу кластера MicroK8S так, чтобы при запросе только по адресу открывался _frontend_ а при добавлении /api - _backend_.
3. Продемонстрировать доступ с помощью браузера или `curl` с локального компьютера.
4. Предоставить манифесты и скриншоты или вывод команды п.2.

![image](https://github.com/mingaliev-e/devops-netology/assets/111060072/c846b171-f59b-4440-af58-d6140c591072)

![image](https://github.com/mingaliev-e/devops-netology/assets/111060072/ae7ffbd4-45e2-4e57-8643-f5b77f34dd95)