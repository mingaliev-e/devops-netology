# Домашнее задание к занятию «Базовые объекты K8S»

### Задание 1. Создать Pod с именем hello-world

1. Создать манифест (yaml-конфигурацию) Pod.
2. Использовать image - gcr.io/kubernetes-e2e-test-images/echoserver:2.2.
3. Подключиться локально к Pod с помощью `kubectl port-forward` и вывести значение (curl или в браузере).

Манифест [hello-world.yml](hello-world.yml)

![image](https://github.com/mingaliev-e/devops-netology/assets/111060072/58c935a6-aa5f-4d60-8cd6-c366bc20a599)

![image](https://github.com/mingaliev-e/devops-netology/assets/111060072/557b6721-576f-48bb-b34f-1ced06069246)

### Задание 2. Создать Service и подключить его к Pod

1. Создать Pod с именем netology-web.
2. Использовать image — gcr.io/kubernetes-e2e-test-images/echoserver:2.2.
3. Создать Service с именем netology-svc и подключить к netology-web.
4. Подключиться локально к Service с помощью `kubectl port-forward` и вывести значение (curl или в браузере).

Манифест [netology-web.yml](netology-web.yml)

Манифест [service.yml](service.yml)

![image](https://github.com/mingaliev-e/devops-netology/assets/111060072/ecca6da3-2960-4a88-9471-809c131cd369)

![image](https://github.com/mingaliev-e/devops-netology/assets/111060072/4b338677-68fe-4f17-ad7c-6f73fc6a6085)



