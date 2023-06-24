# Домашнее задание к занятию «Запуск приложений в K8S»

### Задание 1. Создать Deployment и обеспечить доступ к репликам приложения из другого Pod

1. Создать Deployment приложения, состоящего из двух контейнеров — nginx и multitool. Решить возникшую ошибку.
2. После запуска увеличить количество реплик работающего приложения до 2.
3. Продемонстрировать количество подов до и после масштабирования.

![image](https://github.com/mingaliev-e/devops-netology/assets/111060072/0df324c9-0886-442e-b887-695ebe1e8ed1)

![image](https://github.com/mingaliev-e/devops-netology/assets/111060072/3d9bf432-93ac-44cc-8dda-184ac1204902)

4. Создать Service, который обеспечит доступ до реплик приложений из п.1.

![image](https://github.com/mingaliev-e/devops-netology/assets/111060072/6a735b2e-b96a-45bc-afbc-956dbb889c54)

![image](https://github.com/mingaliev-e/devops-netology/assets/111060072/70c4f5c4-7e80-4189-9f33-633ce7af8cd8)

![image](https://github.com/mingaliev-e/devops-netology/assets/111060072/cce8fa0c-dc95-4d60-864b-3511fb7c304e)

5. Создать отдельный Pod с приложением multitool и убедиться с помощью `curl`, что из пода есть доступ до приложений из п.1.

![image](https://github.com/mingaliev-e/devops-netology/assets/111060072/a8d0644d-7bb1-4062-b3c0-37900ee5d823)

### Задание 2. Создать Deployment и обеспечить старт основного контейнера при выполнении условий

1. Создать Deployment приложения nginx и обеспечить старт контейнера только после того, как будет запущен сервис этого приложения.
2. Убедиться, что nginx не стартует. В качестве Init-контейнера взять busybox.
3. Создать и запустить Service. Убедиться, что Init запустился.
4. Продемонстрировать состояние пода до и после запуска сервиса.

![image](https://github.com/mingaliev-e/devops-netology/assets/111060072/e0719b68-e913-4814-8749-0dfbaa592742)