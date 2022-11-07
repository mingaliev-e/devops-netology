# Домашнее задание к занятию "1. Введение в виртуализацию. Типы и функции гипервизоров. Обзор рынка вендоров и областей применения."

## Опишите кратко, как вы поняли: в чем основное отличие полной (аппаратной) виртуализации, паравиртуализации и виртуализации на основе ОС.

Паравиртуализация:
Гипервизорам такого типа необходима ОС для доступа к аппаратным ресурсам хоста. Вм высткпает в роли гостевой ОС которой выделены ресурсы физического сервера

Аппаратная:
Гостевые ОС получают доступ к ресурсам напрямую, нет прослойки ввиде хостовой ОС, все процессы выполняются на процессоре с различными приоритетами.

Виртуализация на основе ОС:
Не позволяет запускать ОС отличное от хостовой т.к роль гипервизора на себя берет ядро хостовой ОС, все контейнеры монитуют устройста хостовой машины

## Выберите один из вариантов использования организации физических серверов, в зависимости от условий использования.

физические сервера:

Системы, выполняющие высокопроизводительные расчеты на GPU.

Т.к расчеты на GPU, то лучше на физическом сервере, так как можно использовать графический процессор на полную мощность

паравиртуализация:

Windows системы для использования бухгалтерским отделом.

Различные сервера по типу 1С и прочих лучше строить в кластере из нескольких нод паравиртуализации например в Proxmox, а данные хранить на отдельных СХД или NAS. При такой конфигурации проще создавать бэкапы самих ВМ, данные хранятся отдельно, плюс есть возможность сделать переезд на горячую между нодами

виртуализация уровня ОС.

Высоконагруженная база данных, чувствительная к отказу.

Различные web-приложения.

БД и веб приложения логичнее развлорачивать в контейнерах прикрепляя волюмы, так, эти сервисы будут потреблять только неообходимое количество системных ресурсов, плюс в слючае отказа легко пересобрать контейнер 

## Выберите подходящую систему управления виртуализацией для предложенного сценария. Детально опишите ваш выбор.

1 Я бы выбрал Proxmox, т.к он очень простой в настройке и администрировании, можно строить кластер для балансировки нагрузки, так же есть Proxmox Backup Server с удобным интерфейсом хранения бекапов, автоматические бэкапы очень легко настраиваются с любым сценарием и т.д

2 Xen PV - Высокая производительность 

3 Xen PV - Высокая производительность, хорошо совместим с Windows, OpenSource решение или Hyper-V, т.к продукт Microsoft и хорошо совместим с windows 

4 Virlual Box - т.к. удобно разворачивать машины через Vagrant

## Опишите возможные проблемы и недостатки гетерогенной среды виртуализации (использования нескольких систем управления виртуализацией одновременно) и что необходимо сделать для минимизации этих рисков и проблем. Если бы у вас был выбор, то создавали бы вы гетерогенную среду или нет? Мотивируйте ваш ответ примерами.

Во-первых, это вопрос к квалификации сторудников, имеют ли они одинаково высокие знания в администрировании различных систем виртуализации, во-вторых это может наложить определеннные трудности при переезде ВМ из одной среды в другую, так как не все среды виртуализации поддерживают конвертацию ВМ из другой среды в свою.
Если есть какое то обоснованное разделение этих ВМ в разные среды, например в одной среде у нас будут ПРОД сервера в другой ТЕСТ, чтоб кто-то из сотрудников своими культяпками случайно не удалил какую то прод ВМ (что не редко встречается на самом деле), то возможно да, стоит рассмотреть вариант разных сред, в ином случае, без острой необходимости не вижу в этом смысла, все зависит от того какие сервисы нужны, на каких ОС они работают, по какому принципу их можно разделить и т.д, этот вопрос нужно разбирать для каждого случаю индивидуально.  

# Домашнее задание к занятию "2. Применение принципов IaaC в работе с виртуальными машинами"

## Задача 1
Опишите своими словами основные преимущества применения на практике IaaC паттернов.

Ускоряет процесс разворачивания необходимой инфраструктуры, возможность управления архитектурой с одного сервера, решение монотонных и длительных задач одним плейбуком или одной командой на множестве серверов. Дает возможность быстро производить доставку кода для непрерывной его интеграции в продукте, а так же провести тестирование 

Какой из принципов IaaC является основополагающим?

Идемпотентность


## Задача 2

Чем Ansible выгодно отличается от других систем управление конфигурациями?

не требует агентов на управляемых хостах использует метод push, написан на Python, простой в использовании, быстро развивается, 

Какой, на ваш взгляд, метод работы систем конфигурации более надёжный push или pull?

Pull, т.к. Ни один внешний клиент не имеет прав на внесение изменений в кластер, все обновления накатываются изнутри.
Pull-инструменты могут быть распределены по разным пространствам имен и правами доступа
Pull сам инициирует запросы
Минус Push - Сильная зависимость от CD-системы, поскольку нужные нам пайплайны, возможно, изначально написаны под Gitlab Runners, а затем команда решит перейти на Azure DevOps или Jenkins… и придется производить миграцию большого количества пайплайнов сборки.

## Задача 3
Установить на личный компьютер:

Выполнено

vagrant@server1:~$ VBoxManage --version
7.0.2

vagrant@server1:~$ vagrant -v
Vagrant 2.3.2

vagrant@server1:~$ ansible --version
ansible [core 2.12.5]
  config file = None
  configured module search path = ['/Users/ilya/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /Users/ilya/Documents/netology/devops/ansible/ansible/lib/python3.9/site-packages/ansible
  ansible collection location = /Users/ilya/.ansible/collections:/usr/share/ansible/collections
  executable location = /Users/ilya/Documents/netology/devops/ansible/ansible/bin/ansible
  python version = 3.9.10 (main, Jan 15 2022, 11:48:04) [Clang 13.0.0 (clang-1300.0.29.3)]
  jinja version = 3.1.2
  libyaml = True

## Задача 4 (*)
Воспроизвести практическую часть лекции самостоятельно.

Создать виртуальную машину.
Зайти внутрь ВМ, убедиться, что Docker установлен с помощью команды

    vagrant@server1:~$ docker ps
    CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
    vagrant@server1:~$


















