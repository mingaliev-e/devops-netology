Домашнее задание к занятию 12 «GitLab»

Настроил инстнас GitLab в YC и создал новый проект 

![image](https://user-images.githubusercontent.com/111060072/226983225-577f8218-92d5-4cfb-994c-755e2a427ef7.png)

Написал Dockerfile 

![image](https://user-images.githubusercontent.com/111060072/226983610-9fe9026a-2f4e-486d-9ba3-7bce6b26f062.png)

Настроил K8S кластре в YC

![image](https://user-images.githubusercontent.com/111060072/226984455-4b71c060-008b-4c1b-a6ab-4f8165d9945f.png)

Написал конфиг .gitlab-ci.yml и проверил работу 

![image](https://user-images.githubusercontent.com/111060072/226984856-1d2d026a-bdaf-4a62-be69-543e481ce1cb.png)

![image](https://user-images.githubusercontent.com/111060072/226982968-ebbd8bdf-5327-433e-810f-bf9cefa0f025.png)

Образ залился в Container Registry и поднялся новый под 

![image](https://user-images.githubusercontent.com/111060072/226985147-ce9d5e33-0c26-4caa-9bb6-095e7ce9c126.png)

Создал Issue

![image](https://user-images.githubusercontent.com/111060072/226988204-bb42d4ec-7950-40ad-9e1a-9d7906845081.png)

Поправил скрипт и закомитил

![image](https://user-images.githubusercontent.com/111060072/226988090-1766af4d-4aac-43cc-824c-9b8d6c57170b.png)

Проверил что что все прошло успешно 

![image](https://user-images.githubusercontent.com/111060072/226997363-e756057e-42c1-4a8e-9796-45d15d810328.png)

Сделал Merge request

![image](https://user-images.githubusercontent.com/111060072/226999747-c6950b9a-75d9-4e1f-9efc-287b40ec7aea.png)

Build

![image](https://user-images.githubusercontent.com/111060072/227001701-4d28579d-e90d-4226-9335-c507f9407f8d.png)

Deploy

![image](https://user-images.githubusercontent.com/111060072/227001814-405e8769-974a-48bf-8011-45bf2094674e.png)

Поднял docker контейнер для проверки

    [root@1977839cfac8 opt]# curl localhost:5290/get_info
    {"version": 3, "method": "GET", "message": "Running"}
    [root@1977839cfac8 opt]#

Закрыл Issue

![image](https://user-images.githubusercontent.com/111060072/227000501-32c603ee-ba37-4573-8819-3b1da097b198.png)

Список подов 

![image](https://user-images.githubusercontent.com/111060072/227001070-5f5bcdac-7d2b-4e7a-bbc8-7532ebc6b312.png)
