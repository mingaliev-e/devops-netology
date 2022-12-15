# Домашнее задание по лекции "Облачные провайдеры и синтаксис Terraform"

## Задача 1

Яндекс облако уже было настроено на предыдущих заданиях

## Задача 2

Ответ на вопрос: при помощи какого инструмента (из разобранных на прошлом занятии) можно создать свой образ ami?

Образы можно создавать с помощью Packer-a

Ссылка на репозиторий с исходной конфигурацией терраформа.

https://github.com/mingaliev-e/devops-netology/tree/main/terraform

Файл с блоком провайдера практически пустой, потому что cloud_id folder_id и token_id я создал переменными export YC_TOKEN=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX 

Лог terraform plan в файле https://github.com/mingaliev-e/devops-netology/blob/main/terraform/tf_plan.log

В облаке все успешно завелось, создалась вм ubuntu-22.04 и смог подключиться по ssh 
