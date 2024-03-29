# Дипломная работа

**Этот скрипт** представляет собой Telegram-бота, способного взаимодействовать с API системы мониторинга Zabbix. Он позволяет пользователям выполнять различные действия, такие как просмотр групп хостов, хостов в этих группах, проверка статусов, включение/отключение хостов и получение триггеров, связанных с хостами.

## Предварительные требования:
- Python 3.8 или выше
- Доступ к экземпляру Zabbix с включенным API
- Токен Telegram Bot
- URL Zabbix

## Установка:
1. Клонируйте или загрузите репозиторий, содержащий скрипт.
2. Убедитесь, что у вас установлен Python 3.8 или выше.
3. Установите необходимые зависимости, запустив:

-----

pip install -r requirements.txt

-----


## Настройка:
1. Получите токен Telegram Bot, создав нового бота с помощью BotFather в Telegram.
2. Настройте переменные среды:
- `BOT_TOKEN`: Ваш токен Telegram Bot.
- `ZABBIX_URL`: URL вашего экземпляра Zabbix.
3. Убедитесь, что ваш экземпляр Zabbix разрешает доступ к API и что у вас есть действительный логин и пароль.

## Использование:
1. Запустите скрипт, используя Python:

-----

python zbx_assistent.py

-----

   Либо в докер контейнере используя 

-----

docker pull m222777/zbx-tg_assistent-bot:1.0.0

docker run -d --name container_name image_name (используйте -e "BOT_TOKEN="your_bot_token" -e ZABBIX_URL="your_zabbix_api_url" если не задали переменные)

-----


2. Начните разговор с вашим Telegram-ботом.
3. Используйте команду `/start`, чтобы инициировать взаимодействие и предоставить свой логин и пароль Zabbix в формате: `login:password`.
4. Взаимодействуйте с ботом, чтобы выполнять различные действия, такие как просмотр групп хостов, выбор хостов, проверка статусов, включение/отключение хостов и получение триггеров.

## Важные замечания:
- Убедитесь, что ваш экземпляр Zabbix доступен, и предоставленные учетные данные верны.
- Обеспечьте доступ к API Zabbix и доступность сети, где запускается скрипт.
- Скрипт широко использует API Zabbix, поэтому любые изменения в структуре API могут повлиять на его функциональность.
- Этот бот предоставляет базовую функциональность и может быть дополнен в соответствии с вашими требованиями.

## Участие в разработке:
Приглашаем к участию! Если вы обнаружили проблемы или у вас есть предложения по улучшению, не стесняйтесь создать запрос на изменение или запрос на вытягивание на GitHub.


Для получения подробной документации по API Zabbix обратитесь к [Документации по API Zabbix](https://www.zabbix.com/documentation/current/manual/api).

# Процесс выполнения дипломной работы 

PS. Дипломную работу выполнял на основе того, что сейчас разрабатываю на работе, не стал сильно замаричиваться с количеством нод кластера и тд.
В идеале конечно использовать минимум 2 мастер ноды и 3 воркера в разных зонах, но все это делается очень просто, по этому не стал на этом заострять внимание

## Инфраструктура кластера K8S

Все ВМ развернуты с помощью terraform

![image](https://github.com/mingaliev-e/devops-netology/assets/111060072/08f5361f-f62d-4870-a52a-33a5afe7bb25)

![image](https://github.com/mingaliev-e/devops-netology/assets/111060072/05d400d7-ffb0-4750-8ea2-99d202e29706)

Так же статус лог сохраняется в созданый Bucket-backend для Terraform

![image](https://github.com/mingaliev-e/devops-netology/assets/111060072/130f0940-6a4a-419c-a15d-dc10d033cbbd)

![image](https://github.com/mingaliev-e/devops-netology/assets/111060072/4ac1426f-4a32-4d37-a9ea-4e9177901ea5)

![image](https://github.com/mingaliev-e/devops-netology/assets/111060072/ce106e7e-dd1d-45fc-925f-e6e5ed6ca7c0)

![image](https://github.com/mingaliev-e/devops-netology/assets/111060072/b643f9d4-ed89-4358-89aa-d5951db064f1)

![image](https://github.com/mingaliev-e/devops-netology/assets/111060072/da1dc53f-a0ec-4d42-bfc2-2dad8698c880)

Так же для удобство созданы 2 статических ip для мастер нод 

![image](https://github.com/mingaliev-e/devops-netology/assets/111060072/142d2140-9b30-421f-b782-d4c9449f8ac0)

Кластер состоит из 2 master нод и 2 worker нод

Развертывание выполнялось с помощью kubespray

![image](https://github.com/mingaliev-e/devops-netology/assets/111060072/bc9e02c9-5de4-4d8e-b691-9787444ff688)

## GitLab

Так же в YC развернут инстанс GitLab В котором хранятся все файлы приложения и настроен [.gitlab-ci.yml](gitlab-ci.yml)

Под Gitlab-Runner не стал поднимать отдельную виртуалку или под, настроил его просто на сервере Zabbix 

![image](https://github.com/mingaliev-e/devops-netology/assets/111060072/cfebbaa7-17d8-4316-a589-8e5bbdb4a98c)

Данный pipeline проводит тест скрипта на ошибки после чего билдит приложение, добавляет тег версии и пушит в Docker Hub

![image](https://github.com/mingaliev-e/devops-netology/assets/111060072/8a1bba88-5584-43ca-af20-38f58e3591ec)

[Dockerfile](Dockerfile)

[requirements.txt](requirements.txt)

После этого происходит Deploy приложения и поднимаются поды в k8s

[Manifest](k8s_manifests/app.yml)

Pipeline запускается только если создан тег от мастер ветки, название тега прикрепляется к тегу образа, который будет запушен в Docker Hub

![image](https://github.com/mingaliev-e/devops-netology/assets/111060072/77c08a47-f0c0-49b3-a7c7-e9ecd5674822)

В результате мы получаем запущенное приложение бота в кластере k8s

![image](https://github.com/mingaliev-e/devops-netology/assets/111060072/be7ad04f-f22e-4a11-83b6-fd682e17c531)

## Zabbix server

Мониторинг развернут просто на виртуалке, обычный zabbix с postgresql

# Демонстрация работы бота

![image](https://github.com/mingaliev-e/devops-netology/assets/111060072/50927467-a58f-477e-8be5-c754aa59c14c)
![image](https://github.com/mingaliev-e/devops-netology/assets/111060072/20442a18-c550-4604-b6cf-95450cad0d50)
![image](https://github.com/mingaliev-e/devops-netology/assets/111060072/c4a0a0b5-5bce-4b3d-b541-9ad65071f82d)

![image](https://github.com/mingaliev-e/devops-netology/assets/111060072/53d761de-5f75-4051-bd2e-7de2e9a7afe7)
![image](https://github.com/mingaliev-e/devops-netology/assets/111060072/d27d5e58-2edd-4d44-ad22-6da0dd3773b8)

PS. Все доступы к хост группам и хостам работают в соответсвии с правами доступа пользователя




