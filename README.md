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



























