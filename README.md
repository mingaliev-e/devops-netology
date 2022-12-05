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
