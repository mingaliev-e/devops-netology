# Домашнее задание к занятию "4.1. Командная оболочка Bash: Практические навыки"

## Обязательная задача 1

Есть скрипт:
```bash
a=1
b=2
c=a+b
d=$a+$b
e=$(($a+$b))
```

Какие значения переменным c,d,e будут присвоены? Почему?

| Переменная  | Значение | Обоснование |
| ------------- | ------------- | ------------- |
| `c`  | a+b  | Не указан знак $ соответственно не объявлено, что это переменные, в данном случае a+b это просто строчные символы |
| `d`  | 1+2  | в этом случае переменные объявлены, но все равно это строки, значение переменных взяты, но знак + и сами переменные типа string |
| `e`  | 3  | Перемннные преобразованы в целые числа и выполнена арифметическая операция + |


## Обязательная задача 2
На нашем локальном сервере упал сервис и мы написали скрипт, который постоянно проверяет его доступность, записывая дату проверок до тех пор, пока сервис не станет доступным (после чего скрипт должен завершиться). В скрипте допущена ошибка, из-за которой выполнение не может завершиться, при этом место на Жёстком Диске постоянно уменьшается. Что необходимо сделать, чтобы его исправить:
```bash
while ((1==1)
do
	curl https://localhost:4757
	if (($? != 0))
	then
		date >> curl.log
	fi
done
```

### Ваш скрипт:
```bash
while ((1==1))
do
        curl https://localhost:4757
        if (($? != 0))
        then
                date >> curl.log
        else     ### Иначе 
        break    ### условие выхода из цикла по доступности сервиса.
        fi

sleep 60  ### Таймаут проверки раз в минуту   
done
```

## Обязательная задача 3
Необходимо написать скрипт, который проверяет доступность трёх IP: `192.168.0.1`, `173.194.222.113`, `87.250.250.242` по `80` порту и записывает результат в файл `log`. Проверять доступность необходимо пять раз для каждого узла.

### Ваш скрипт:
```bash
ipadd=(192.168.0.1 173.194.222.113 87.250.250.24)
timeout=3
port=80


for host in ${ipadd[@]}
do
        for ((j=0; j < 5; j++))
        do
                date >> log.txt
                curl -Is --connect-timeout $timeout $host:$port > /dev/null
                echo $host status code=$? >>log.txt
        done
done

```

## Обязательная задача 4
Необходимо дописать скрипт из предыдущего задания так, чтобы он выполнялся до тех пор, пока один из узлов не окажется недоступным. Если любой из узлов недоступен - IP этого узла пишется в файл error, скрипт прерывается.

### Ваш скрипт:
```bash
ipadd=(192.168.0.1 173.194.222.113 87.250.250.24)
timeout=3
port=80
res=0
while (($res==0))
do
        for host in ${ipadd[@]}
        do
                for ((j=0; j < 5; j++))
                do
                        date >> log.txt
                        curl -Is --connect-timeout $timeout $host:$port > /dev/null
                        res=$?

                        if (($res != 0))
                        then
                                echo $host is down > error.log
                                break
                        else
                                echo $host status code=$res >>log.txt
                        fi
                done
                if (($res != 0))
                then
                        break
                fi
        done
done

```


# Домашнее задание к занятию "4.2. Использование Python для решения типовых DevOps задач"

## Обязательная задача 1

Есть скрипт:
```python
#!/usr/bin/env python3
a = 1
b = '2'
c = a + b
```

### Вопросы:
| Вопрос  | Ответ |
| ------------- | ------------- |
| Какое значение будет присвоено переменной `c`?  | Никакого, строку с целочисленным сложить нельзя. Будет ошибка - TypeError: unsupported operand type(s) for +: 'int' and 'str'  |
| Как получить для переменной `c` значение 12?  | c = str(a) + b  |
| Как получить для переменной `c` значение 3?  | c = a + int(b) |

## Обязательная задача 2
Мы устроились на работу в компанию, где раньше уже был DevOps Engineer. Он написал скрипт, позволяющий узнать, какие файлы модифицированы в репозитории, относительно локальных изменений. Этим скриптом недовольно начальство, потому что в его выводе есть не все изменённые файлы, а также непонятен полный путь к директории, где они находятся. Как можно доработать скрипт ниже, чтобы он исполнял требования вашего руководителя?

```python
#!/usr/bin/env python3

import os

bash_command = ["cd ~/netology/sysadm-homeworks", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
is_change = False
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print(prepare_result)
        break
```

### Ваш скрипт:
```python
import os

bash_command = ["cd /home/admin/devops-netology", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
#is_change = False
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print(f'/home/admin/devops-netology/{prepare_result}') ### Добавил путь до репозитория в вывод 
#        break
```

### Вывод скрипта при запуске при тестировании:
```
[root@localhost python]# ./test.py
/home/admin/devops-netology/branching/merge.sh
/home/admin/devops-netology/has_been_moved.txt
```

## Обязательная задача 3
1. Доработать скрипт выше так, чтобы он мог проверять не только локальный репозиторий в текущей директории, а также умел воспринимать путь к репозиторию, который мы передаём как входной параметр. Мы точно знаем, что начальство коварное и будет проверять работу этого скрипта в директориях, которые не являются локальными репозиториями.

### Ваш скрипт:
```python
import os, sys

path = sys.argv[1]

bash_command = ["cd " + path, "git status"]
result_os = os.popen(' && '.join(bash_command)).read()

for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print(f'{path}/{prepare_result}') ### Добавил путь до репозитория в вывод
```

### Вывод скрипта при запуске при тестировании:
```
[root@localhost python]# ./test.py /home/admin/devops-netology
/home/admin/devops-netology/branching/merge.sh
/home/admin/devops-netology/has_been_moved.txt
[root@localhost python]# ./test.py /home/admin
fatal: not a git repository (or any of the parent directories): .git
[root@localhost python]#
[root@localhost python]# ./test.py /home/admin/devops-netologys
/bin/sh: line 0: cd: /home/admin/devops-netologys: No such file or directory
[root@localhost python]#

```
Скрипт работает корректно, если папка не является локальным репозиторием или её не существует выводятся соответсвующие ошибки 

## Обязательная задача 4
1. Наша команда разрабатывает несколько веб-сервисов, доступных по http. Мы точно знаем, что на их стенде нет никакой балансировки, кластеризации, за DNS прячется конкретный IP сервера, где установлен сервис. Проблема в том, что отдел, занимающийся нашей инфраструктурой очень часто меняет нам сервера, поэтому IP меняются примерно раз в неделю, при этом сервисы сохраняют за собой DNS имена. Это бы совсем никого не беспокоило, если бы несколько раз сервера не уезжали в такой сегмент сети нашей компании, который недоступен для разработчиков. Мы хотим написать скрипт, который опрашивает веб-сервисы, получает их IP, выводит информацию в стандартный вывод в виде: <URL сервиса> - <его IP>. Также, должна быть реализована возможность проверки текущего IP сервиса c его IP из предыдущей проверки. Если проверка будет провалена - оповестить об этом в стандартный вывод сообщением: [ERROR] <URL сервиса> IP mismatch: <старый IP> <Новый IP>. Будем считать, что наша разработка реализовала сервисы: `drive.google.com`, `mail.google.com`, `google.com`.

### Ваш скрипт:
```python

import socket
import time

hosts = {'drive.google.com': None, 'mail.google.com': None, 'google.com': None}

while True:
  for host in hosts:
    time.sleep(2)
    ip = socket.gethostbyname(host)
    print(host + ' - ' + ip)
    if ip != hosts[host]:
      print('[ERROR] ' + host + ' IP mistmatch: ' + str(hosts[host]) + ' ' + ip)
      hosts[host] = ip
```

### Вывод скрипта при запуске при тестировании:
```
[root@localhost python]# ./ip.py
drive.google.com - 74.125.131.194
[ERROR] drive.google.com IP mistmatch: None 74.125.131.194
mail.google.com - 108.177.14.17
[ERROR] mail.google.com IP mistmatch: None 108.177.14.17
google.com - 74.125.131.138
[ERROR] google.com IP mistmatch: None 74.125.131.138
drive.google.com - 74.125.131.194
mail.google.com - 108.177.14.19
[ERROR] mail.google.com IP mistmatch: 108.177.14.17 108.177.14.19
google.com - 74.125.131.113
[ERROR] google.com IP mistmatch: 74.125.131.138 74.125.131.113
drive.google.com - 74.125.131.194
mail.google.com - 108.177.14.17
[ERROR] mail.google.com IP mistmatch: 108.177.14.19 108.177.14.17
google.com - 74.125.131.138
[ERROR] google.com IP mistmatch: 74.125.131.113 74.125.131.138
drive.google.com - 74.125.131.194
mail.google.com - 108.177.14.18
[ERROR] mail.google.com IP mistmatch: 108.177.14.17 108.177.14.18
google.com - 74.125.131.139
[ERROR] google.com IP mistmatch: 74.125.131.138 74.125.131.139
drive.google.com - 74.125.131.194
mail.google.com - 108.177.14.83

```
