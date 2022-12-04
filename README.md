# Домашнее задание к занятию "6.4. PostgreSQL"

## Задача 1

    # docker pull postgres:13
    13: Pulling from library/postgres
    Digest: sha256:3c6a77caf1ef2ae91ef1a2cdc2ae219e65e9ea274fbfa0d44af3ec0fccef0d8d
    Status: Image is up to date for postgres:13
    docker.io/library/postgres:13
    
    # docker run -d --name postgres_db -e POSTGRES_PASSWORD=postgres -p 5432:5432 -v ~/postgres/data:/var/lib/postgresql/data -v ~/postgres/backup:/var/lib/postgresql/backup postgres:13
    672b1f74cd574d359daed05c145b22665743557f2b935aba8646632927efd34d
    
    docker exec -ti 672b1f74cd57 bash
    root@672b1f74cd57:/# su - postgres
    postgres@672b1f74cd57:~$ psql
    
    \l - список БД
    \c[onnect] {[DBNAME|- USER|- HOST|- PORT|-] | conninfo} connect to new database (currently "postgres") - подключение к БД
    \dt[S+] [PATTERN] - список таблиц
    \d[S+]  NAME - описание содержимого таблиц
    \q - выход из psql
    
## Задача 2

    root@672b1f74cd57:/# psql -U postgres test_database -f /var/lib/postgresql/backup/test_dump.sql
    SET
    SET
    SET
    SET
    SET
     set_config
    ------------

    (1 row)

    SET
    SET
    SET
    SET
    SET
    SET
    CREATE TABLE
    ALTER TABLE
    CREATE SEQUENCE
    ALTER TABLE
    ALTER SEQUENCE
    ALTER TABLE
    COPY 8
     setval
    --------
          8
    (1 row)

    ALTER TABLE

![image](https://user-images.githubusercontent.com/111060072/205492286-0aa66f7a-ef2d-450c-afcd-95126bd78c80.png)

## Задача 3

Можно было, если на этапе проетирования сразу создавать секционированную таблицу(примеры есть в офф доке https://www.postgresql.org/docs/current/ddl-partitioning.html) 

    BEGIN;
    CREATE TABLE orders_new(id SERIAL, title VARCHAR(80) NOT NULL, price integer DEFAULT 0) PARTITION BY RANGE (price);
    CREATE TABLE orders_price_gt_499 PARTITION OF orders_new FOR VALUES FROM (500) TO (2147483647);
    CREATE TABLE orders_price_lte_499 PARTITION OF orders_new FOR VALUES FROM (0) TO (500);
    INSERT INTO orders_new SELECT * FROM orders;
    DROP TABLE orders;
    ALTER TABLE orders_new RENAME TO orders;
    COMMIT;

## Задача 4

    root@672b1f74cd57:/# pg_dump -U postgres -d test_database > /var/lib/postgresql/backup/new_backup.sql

Добавить UNIQUE к полям title 

    CREATE TABLE public.orders_price_lte_499 (
        id integer DEFAULT nextval('public.orders_new_id_seq'::regclass) NOT NULL,
        title character varying(80) NOT NULL UNIQUE,
        price integer DEFAULT 0
    );

    CREATE TABLE public.orders_price_gt_499 (
        id integer DEFAULT nextval('public.orders_new_id_seq'::regclass) NOT NULL,
        title character varying(80) NOT NULL UNIQUE,
        price integer DEFAULT 0
    );


# Домашнее задание к занятию "6.3. MySQL"

## Задача 1

    docker pull mysql:8.0
    8.0: Pulling from library/mysql
    Digest: sha256:66efaaa129f12b1c5871508bc8481a9b28c5b388d74ac5d2a6fc314359bbef91
    Status: Image is up to date for mysql:8.0
    docker.io/library/mysql:8.0
    docker volume create vol_mysql
    vol_mysql
    docker run --rm --name mysql-docker -e MYSQL_ROOT_PASSWORD=mysql -ti -p 3306:3306 -v vol_mysql:/etc/mysql/ mysql:8.0

Найдите команду для выдачи статуса БД и приведите в ответе из ее вывода версию сервера БД:

    Server version:         8.0.31 MySQL Community Server - GPL
    
Подключитесь к восстановленной БД и получите список таблиц из этой БД:

    docker cp virt-homeworks/06-db-03-mysql/test_data/test_dump.sql c2c0053d66c6:/etc/mysql
    docker exec -ti c2c0053d66c6 bash
    
    bash-4.4# export DBNAME=test_db
    bash-4.4# mysql -u root -p
    mysql> CREATE DATABASE test_db;

    bash-4.4# mysql -u root -p ${DBNAME} < /etc/mysql/test_dump.sql
    bash-4.4# mysql -u root -p
    mysql> select count(*) from orders where price >300;
    +----------+
    | count(*) |
    +----------+
    |        1 |
    +----------+
    1 row in set (0.00 sec)

## Задача 2

    mysql> create user 'test'@'localhost'
        -> identified with mysql_native_password by 'test-pass'
        -> with max_queries_per_hour 100
        -> password expire interval 180 day
        -> failed_login_attempts 3
        -> attribute '{"fname": "James","lname": "Pretty"}';
    Query OK, 0 rows affected (0.08 sec)

    mysql> GRANT Select ON test_db.orders TO 'test'@'localhost';
    Query OK, 0 rows affected, 1 warning (0.01 sec)

    mysql> SELECT * FROM INFORMATION_SCHEMA.USER_ATTRIBUTES WHERE USER='test';
    +------+-----------+---------------------------------------+
    | USER | HOST      | ATTRIBUTE                             |
    +------+-----------+---------------------------------------+
    | test | localhost | {"fname": "James", "lname": "Pretty"} |
    +------+-----------+---------------------------------------+
    1 row in set (0.00 sec)

## Задача 3

    mysql> show table status where name = 'orders';
    +--------+--------+---------+------------+------+----------------+-------------+-----------------+--------------+-----------+----------------+---------------------+---------------------+------------+--------------------+----------+----------------+---------+
    | Name   | Engine | Version | Row_format | Rows | Avg_row_length | Data_length | Max_data_length | Index_length | Data_free | Auto_increment | Create_time         | Update_time         | Check_time | Collation          | Checksum | Create_options | Comment |
    +--------+--------+---------+------------+------+----------------+-------------+-----------------+--------------+-----------+----------------+---------------------+---------------------+------------+--------------------+----------+----------------+---------+
    | orders | InnoDB |      10 | Dynamic    |    5 |           3276 |       16384 |               0 |            0 |         0 |              6 | 2022-12-04 10:47:15 | 2022-12-04 10:47:15 | NULL       | utf8mb4_0900_ai_ci |     NULL |                |         |
    +--------+--------+---------+------------+------+----------------+-------------+-----------------+--------------+-----------+----------------+---------------------+---------------------+------------+--------------------+----------+----------------+---------+
    1 row in set (0.00 sec)

## InnoDB 

    mysql> ALTER TABLE orders ENGINE = MyISAM;
    Query OK, 5 rows affected (0.05 sec)
    Records: 5  Duplicates: 0  Warnings: 0

    mysql> ALTER TABLE orders ENGINE = InnoDB;
    Query OK, 5 rows affected (0.17 sec)
    Records: 5  Duplicates: 0  Warnings: 0

    mysql> SHOW PROFILES;
    +----------+------------+-----------------------------------------+
    | Query_ID | Duration   | Query                                   |
    +----------+------------+-----------------------------------------+
    |       19 | 0.00305375 | show table status where name = 'orders' |
    |       20 | 0.05543375 | ALTER TABLE orders ENGINE = MyISAM      |
    |       21 | 0.16775600 | ALTER TABLE orders ENGINE = InnoDB      |
    +----------+------------+-----------------------------------------+
    3 rows in set, 1 warning (0.00 sec)

## Задача 4

    [mysqld]
    pid-file        = /var/run/mysqld/mysqld.pid
    socket          = /var/run/mysqld/mysqld.sock
    datadir         = /var/lib/mysql
    secure-file-priv= NULL

    innodb_flush_log_at_trx_commit = 2 
    innodb_file_per_table = 1
    autocommit = 0
    innodb_log_buffer_size	= 1M
    key_buffer_size = 1228М
    max_binlog_size	= 100M


# Домашнее задание к занятию "6.2. SQL"

## Задача 1

![image](https://user-images.githubusercontent.com/111060072/204028966-389b00c5-5ad3-4295-bc5e-6e389d5e7a82.png)

## Задача 2

![image](https://user-images.githubusercontent.com/111060072/204051827-7d10ab21-5a3b-4239-bdb6-094fa56a1445.png)

![image](https://user-images.githubusercontent.com/111060072/204035782-0e4ea6f2-733a-4ff9-9135-418e747174ec.png)

## Задача 3

    test_db=# insert into orders VALUES (1, 'Шоколад', 10), (2, 'Принтер', 3000), (3, 'Книга', 500), (4, 'Монитор', 7000), (5, 'Гитара', 4000);
    INSERT 0 5
    test_db=# insert into clients VALUES (1, 'Иванов Иван Иванович', 'USA'), (2, 'Петров Петр Петрович', 'Canada'), (3, 'Иоганн Себастьян Бах', 'Japan'), (4, 'Ронни Джеймс Дио', 'Russia'), (5, 'Ritchie Blackmore', 'Russia');
    INSERT 0 5
    test_db=# select count (*) from orders;
     count
    -------
         5
    (1 row)

    test_db=# select count (*) from clients;
     count
    -------
         5
    (1 row)

## Задача 4

    test_db=# UPDATE clients SET booking_id = (SELECT id FROM orders WHERE name = 'Книга') WHERE surname = 'Иванов Иван Иванович';
    UPDATE 1
    test_db=# UPDATE clients SET booking_id = (SELECT id FROM orders WHERE name = 'Монитор') WHERE surname = 'Петров Петр Петрович';
    UPDATE 1
    test_db=# UPDATE clients SET booking_id = (SELECT id FROM orders WHERE name = 'Гитара') WHERE surname = 'Иоганн Себастьян Бах';
    UPDATE 1

    test_db=# SELECT * FROM clients WHERE booking_id IS NOT NULL;
     id |       surname        | country | booking_id
    ----+----------------------+---------+------------
      1 | Иванов Иван Иванович | USA     |          3
      2 | Петров Петр Петрович | Canada  |          4
      3 | Иоганн Себастьян Бах | Japan   |          5
    (3 rows)

    test_db=#

## Задача 5

    test_db=# EXPLAIN SELECT * FROM clients WHERE booking_id IS NOT NULL;
                            QUERY PLAN
    -----------------------------------------------------------
     Seq Scan on clients  (cost=0.00..18.10 rows=806 width=72)
       Filter: (booking_id IS NOT NULL)
    (2 rows)

    test_db=#

Из документации:
Приблизительная стоимость запуска. Это время, которое проходит, прежде чем начнётся этап вывода данных, например для сортирующего узла это время сортировки.

Приблизительная общая стоимость. Она вычисляется в предположении, что узел плана выполняется до конца, то есть возвращает все доступные строки. На практике родительский узел может досрочно прекратить чтение строк дочернего (см. приведённый ниже пример с LIMIT).

Ожидаемое число строк, которое должен вывести этот узел плана. При этом так же предполагается, что узел выполняется до конца.

Ожидаемый средний размер строк, выводимых этим узлом плана (в байтах).

## Задача 6

Создал бекап

    pg_dump -U postgres test_db > /var/lib/postgresql/backup/test_db_backup.sql
    
Удалил старый и запустил новый контейнер, создал базу test_db, и восстановил данные из бекапа командой:

    psql -U postgres test_db -f /var/lib/postgresql/backup/test_db_backup.sql

# Домашнее задание к занятию "6.1. Типы и структура СУБД"

## Задача 1

Электронные чеки в json виде: Документо-ориентированная - классичиское применение документов json

Склады и автомобильные дороги для логистической компании - Сетевая или графовая БД

Генеалогические деревья - подойдут БД использующие иерархические модель данных

Кэш идентификаторов клиентов с ограниченным временем жизни для движка аутенфикации - проще хранить в озу, так что Redis или Memcached

Отношения клиент-покупка для интернет-магазина - реляционные БД, т.к простая связь между двумя сущностями

## Задача 2

Вы создали распределенное высоконагруженное приложение и хотите классифицировать его согласно CAP-теореме. Какой классификации по CAP-теореме соответствует ваша система, если (каждый пункт - это отдельная реализация вашей системы и для каждого пункта надо привести классификацию):

    Данные записываются на все узлы с задержкой до часа (асинхронная запись)
    При сетевых сбоях, система может разделиться на 2 раздельных кластера
    Система может не прислать корректный ответ или сбросить соединение

    CA | PC/EL
    PA | PA/EL
    PC | PA/EC
    
## Задача 3

Могут ли в одной системе сочетаться принципы BASE и ACID? Почему?

Нет, не могут. BASE - это противопоставление ACID. Например, ACID гарантирует консистентность данных после транзакции, BASE же допускает возврат неверных данных.

## Задача 4

Вам дали задачу написать системное решение, основой которого бы послужили:
    
    фиксация некоторых значений с временем жизни
    реакция на истечение таймаута
    
Вы слышали о key-value хранилище, которое имеет механизм Pub/Sub. Что это за система? Какие минусы выбора данной системы?

Redis. 

    Минусы:
    Довольно высокая вероятность потери данных
    Ограничение в рамках памяти т.к это ОЗУ
    Отсутсвие поддержки  языка SQL
    При отказе сервера данные не успеют записаться на диск слепком, по этому будут потеряны

# Домашнее задание "Оркестрация кластером Docker контейнеров на примере Docker Swarm."

## Задача 1
Дайте письменые ответы на следующие вопросы:

В чём отличие режимов работы сервисов в Docker Swarm кластере: replication и global?

В режиме global сервис запускается на всех нодах. Если используется режим replication, то указывается количество реплик используемых для сервиса.

Какой алгоритм выбора лидера используется в Docker Swarm кластере?

Используется так называемый алгоритм поддержания распределенного консенсуса — Raft. Консенсус предполагает согласование значений несколькими серверами. Как только они примут решение о значении, это решение станет окончательным.

Что такое Overlay Network?

Используется для связи контейнеров расположенных на разных хостах. При построении используется уже существующая сеть и технология vxlan. Может быть включено шифрование IPSec.

## Задача 2

![image](https://user-images.githubusercontent.com/111060072/203107924-48653aee-b22c-4520-a98e-10ff277896ae.png)

## Задача 3

![image](https://user-images.githubusercontent.com/111060072/203108013-1811a12e-d2b4-43f6-854e-1cebf1315f67.png)

## Задача 4*

![image](https://user-images.githubusercontent.com/111060072/203109967-6ae4d071-6bd3-4022-8820-798834132583.png)

Команда включает автоблокировку swarm и защищает его ключем шифрования, когда контейнер перезапустится необходимо будет ввести ключ, сгенерированный при вкл автоблокировки

# Домашнее задание к занятию "4. Оркестрация группой Docker контейнеров на примере Docker Compose"

## Задача 1

![image](https://user-images.githubusercontent.com/111060072/201759491-7b876780-c9ff-4ef7-9c7a-ebc0fd231469.png)

## Задача 2

![image](https://user-images.githubusercontent.com/111060072/201786020-1142c5fa-5306-4bb2-a39e-1efa0507d8d5.png)

## Задача 3

![image](https://user-images.githubusercontent.com/111060072/202031816-3af5bfb2-c32e-49b4-a017-2189b6745619.png)


# Домашнее задание к занятию "3. Введение. Экосистема. Архитектура. Жизненный цикл Docker контейнера"

# Задача 1

создайте свой репозиторий на https://hub.docker.com;

выберете любой образ, который содержит веб-сервер Nginx;

создайте свой fork образа;

реализуйте функциональность: запуск веб-сервера в фоне с индекс-страницей, содержащей HTML-код ниже:

Опубликуйте созданный форк в своем репозитории и предоставьте ответ в виде ссылки на https://hub.docker.com/username_repo.

![image](https://user-images.githubusercontent.com/111060072/201379590-3e15634f-c7ba-4e34-97d7-2ae8fa480c3a.png)

![image](https://user-images.githubusercontent.com/111060072/201380141-b0fe3545-3d70-412c-be66-3aab75b4cc4b.png)

    docker pull m222777/webserver

# Задача 2

Подходит ли в этом сценарии использование Docker контейнеров или лучше подойдет виртуальная машина, физическая машина?

Высоконагруженное монолитное java веб-приложение;  Я бы не стал использовать docker т.к принято что один сервис 1 контейнер, а монолит это несколько сервисов на одном сервере, по этому лучше использовать паравиртуализацию или физический сервер.

Nodejs веб-приложение; можно развернуть в docker
Мобильное приложение c версиями для Android и iOS; Лучше использовать виртуализацию

Шина данных на базе Apache Kafka; можно развернуть в docker

Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana; можно развернуть в docker в отдельных контейнерах

Мониторинг-стек на базе Prometheus и Grafana; подходит как разворачивание в docker так и паравиртуализация. Я бы развернул в виртуалках, так проще администрировать, залить все конфиги например в битбакет, настроить ансибл плейбук и jenkins, и автоматически заливать конфиги, плагины и прочее на сервера при коммитах  

MongoDB, как основное хранилище данных для java-приложения; зависит он нагрузки и объема поступаемых данных, если это высоконагруженная БД то лучше физический сервер или в виртуалке 

Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry. Физический сервер или виртулка 

# Задача 3

![image](https://user-images.githubusercontent.com/111060072/201410763-d2aab0ed-145e-48c7-8759-1834bf651644.png)



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
6.1.34r150636

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


















