1 Узнайте о sparse (разряженных) файлах.

Разреженные файлы - это такие файлы, которые занимают меньше дискового пространства, чем их собственный размер. Данная технология не имеет отношения к встроенной в NTFS поддержке компрессии файлов, так как экономия места на диске в sparse-файлах основана на другом принципе. Никакого сжатия данных не осуществляется. Вместо этого, в файле высвобождаются области, занятые одними лишь нулями (0x00).

2 Могут ли файлы, являющиеся жесткой ссылкой на один объект, иметь разные права доступа и владельца? Почему?

Нет, т.к при изменении одного из файлов второй тоже будет изменен, т.к фактически будет меняться цифровой объект на диске, у жестких ссылок всегда один и тот же набор прав

3 Сделайте vagrant destroy на имеющийся инстанс Ubuntu. Замените содержимое Vagrantfile следующим:

Готово ![image](https://user-images.githubusercontent.com/111060072/190217852-4517a434-67cc-4d43-a772-f2895c06d8e8.png)

4 Используя fdisk, разбейте первый диск на 2 раздела: 2 Гб, оставшееся пространство.

![image](https://user-images.githubusercontent.com/111060072/190220204-d66bbec1-e259-469f-8ed7-65f8e770a089.png)
![image](https://user-images.githubusercontent.com/111060072/190220304-047fd609-c95e-4f75-8bce-c6733ac6b814.png)

5 Используя sfdisk, перенесите данную таблицу разделов на второй диск.

![image](https://user-images.githubusercontent.com/111060072/190220824-cc6cd97b-c2ec-46ea-b811-4e875e5486df.png)

6 Соберите mdadm RAID1 на паре разделов 2 Гб.

![image](https://user-images.githubusercontent.com/111060072/190222624-a189bd0e-e0fe-4596-a024-d9f6018709f2.png)

7 Соберите mdadm RAID0 на второй паре маленьких разделов.

![image](https://user-images.githubusercontent.com/111060072/190222936-e04d726d-3d3e-4598-a501-220075afb5a8.png)

8 Создайте 2 независимых PV на получившихся md-устройствах.
         root@vagrant:/home/vagrant# pvcreate /dev/md0 /dev/md1
           Physical volume "/dev/md0" successfully created.
           Physical volume "/dev/md1" successfully created.
           
![image](https://user-images.githubusercontent.com/111060072/190225788-47d45c22-d0bd-4612-9ca2-b8ea60afb4bd.png)

9 Создайте общую volume-group на этих двух PV.

         root@vagrant:/home/vagrant# vgcreate vg1 /dev/md0 /dev/md1
           Volume group "vg1" successfully created

![image](https://user-images.githubusercontent.com/111060072/190225854-dfdd1d96-5401-4b32-a8ae-7bddd39db612.png)

10 Создайте LV размером 100 Мб, указав его расположение на PV с RAID0.

![image](https://user-images.githubusercontent.com/111060072/190226121-4bb5cf6e-635f-424e-8e5f-bfb015a69a08.png)

11 Создайте mkfs.ext4 ФС на получившемся LV.

![image](https://user-images.githubusercontent.com/111060072/190226380-98c4ea1d-f145-41cf-abfa-f1a0e335e9d1.png)

12 Смонтируйте этот раздел в любую директорию, например, /tmp/new.

![image](https://user-images.githubusercontent.com/111060072/190226991-93a8468c-a0e8-4342-b5cc-ca8ea5111c53.png)

13 Поместите туда тестовый файл, например wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz.

![image](https://user-images.githubusercontent.com/111060072/190227127-972269a4-85fd-4f8e-8b4d-5fc17db529b8.png)

14 Прикрепите вывод lsblk.

![image](https://user-images.githubusercontent.com/111060072/190227201-55171cea-d909-4a62-9b5b-591f1489f427.png)

15 Протестируйте целостность файла:

         root@vagrant:/home/vagrant# gzip -t /tmp/new/test.gz
         root@vagrant:/home/vagrant# echo $?
         0

16 Используя pvmove, переместите содержимое PV с RAID0 на RAID1.

         root@vagrant:/home/vagrant# pvmove /dev/md0 /dev/md1
           /dev/md0: Moved: 12.00%
           /dev/md0: Moved: 100.00%
17 Сделайте --fail на устройство в вашем RAID1 md.

         root@vagrant:/home/vagrant# mdadm /dev/md1 -f /dev/sdc1
         mdadm: set /dev/sdc1 faulty in /dev/md1

18 Подтвердите выводом dmesg, что RAID1 работает в деградированном состоянии.

![image](https://user-images.githubusercontent.com/111060072/190229085-d9f74495-6ab8-44c7-8694-938a8fdff9b0.png)

19 Протестируйте целостность файла, несмотря на "сбойный" диск он должен продолжать быть доступен:

         root@vagrant:/home/vagrant# gzip -t /tmp/new/test.gz
         root@vagrant:/home/vagrant# echo $?
         0

20 Погасите тестовый хост, vagrant destroy.

Выполнено:







































































