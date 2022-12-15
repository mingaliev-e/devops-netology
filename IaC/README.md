# Домашнее задание к занятию "7.1. Инфраструктура как код"

Список задач https://github.com/nkiselyov/devops-netology/tree/main/07-terraform-01-intro

## Задача 1. Выбор инструментов

1) Используем неизменяемый сервер, когда будет нужно добавить что то, просто поднимем новый контейнер уже с обновлениями 

2) Для управления будет служить сервер с Ansible

3) Агенты для Ansible не нужны

4) Будем использовать Terraform

Для данного проекта я бы хотел использовать Docker, так как его проще всего грохнуть и поднять заново, из моих предложений ко всему этому стоит добавить что то из GitLab или Bitbucket для контроля версий, так как код будет изменяться и дорабатываться, нужна возможность откатиться или посмотреть ошибки кода.

Так же лучше использовать средство оркестрации. Kubernetes

Teamcity использовать для CI/CD, Ansible для управления конфигурациями, Packer и Terraform для развертывания инфраструктуры 

Дополнительно нужно развернуть мониторинг всего этого хозяйства, например Prometheus + Grafana 

## Задача 2-3. Установка терраформ и Поддержка легаси кода

Скачал архивами с зеркала https://hashicorp-releases.yandexcloud.net/terraform/ и распаковал в /usr/bin/ только переименовал файлы 

      [root@localhost ~]# terraform12 -v
      Terraform v1.2.9
      on linux_amd64

      Your version of Terraform is out of date! The latest version
      is 1.3.6. You can update by downloading from https://www.terraform.io/downloads.html
      [root@localhost ~]#
      [root@localhost ~]# terraform13 -v
      Terraform v1.3.6
      on linux_amd64
