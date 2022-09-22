# Домашнее задание к занятию "3.7. Компьютерные сети, лекция 2"

1  Проверьте список доступных сетевых интерфейсов на вашем компьютере. Какие команды есть для этого в Linux и в Windows?

         Linux - ip link
         Windows Powershell - Get-NetAdapter или Get-NetIPInterface
         Windows CMD - netsh interface show interface или ipconfig /all

2   Какой протокол используется для распознавания соседа по сетевому интерфейсу? Какой пакет и команды есть в Linux для этого?

LLDP. sudo apt install lldp

systemctl start lldpd

lldpctl

3   Какая технология используется для разделения L2 коммутатора на несколько виртуальных сетей? Какой пакет и команды есть в Linux для этого? Приведите пример конфига.

Технология VLAN - Virtual Local Area Network

![image](https://user-images.githubusercontent.com/111060072/191718314-5f3f96d0-a865-4290-9898-486a65a2f4a5.png)

Конфигурация удалится при перезапуске, чтоб не удалялась нужно править конфиг /etc/network/interfaces

4  Какие типы агрегации интерфейсов есть в Linux? Какие опции есть для балансировки нагрузки? Приведите пример конфига.

         Mode-0(balance-rr)
         Mode-1(active-backup)
         Mode-2(balance-xor)
         Mode-3(broadcast)
         Mode-4(802.3ad)
         Mode-5(balance-tlb)
         Mode-6(balance-alb)
         
Пример конфига 

         bonds:
             bond0:
               dhcp4: no
               interfaces: [eth0, eth1]
               parameters: 
                 mode: 802.3ad
                 mii-monitor-interval: 1

5  Сколько IP адресов в сети с маской /29 ? Сколько /29 подсетей можно получить из сети с маской /24. Приведите несколько примеров /29 подсетей внутри сети 10.10.10.0/24.

         vagrant@vagrant:~$ sudo ipcalc 10.10.10.0/29
         Address:   10.10.10.0           00001010.00001010.00001010.00000 000
         Netmask:   255.255.255.248 = 29 11111111.11111111.11111111.11111 000
         Wildcard:  0.0.0.7              00000000.00000000.00000000.00000 111
         =>
         Network:   10.10.10.0/29        00001010.00001010.00001010.00000 000
         HostMin:   10.10.10.1           00001010.00001010.00001010.00000 001
         HostMax:   10.10.10.6           00001010.00001010.00001010.00000 110
         Broadcast: 10.10.10.7           00001010.00001010.00001010.00000 111
         Hosts/Net: 6                     Class A, Private Internet
/29 всего 8 ip адресов, 2 из которых зантяы на ip сети и широковещательный ip 

Из сети /24 можно получить 32 подсети /29

6  Задача: вас попросили организовать стык между 2-мя организациями. Диапазоны 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16 уже заняты. Из какой подсети допустимо взять частные IP адреса? Маску выберите из расчета максимум 40-50 хостов внутри подсети.

100.64.0.0/26

![image](https://user-images.githubusercontent.com/111060072/191722541-a3883e06-0117-4aae-bee8-5b375225ecaa.png)

7  Как проверить ARP таблицу в Linux, Windows? Как очистить ARP кеш полностью? Как из ARP таблицы удалить только один нужный IP?

Ubuntu/Debian

ip neighbour show - показать ARP таблицу

ip neighbour del [ip address] dev [interface] - удалить из ARP таблицы конкретный адрес

ip neighbour flush all - очистить ARP таблицу

Windows

arp -a - показать ARP таблицу

arp -d [ip address] - удалить из ARP таблицы конкретный адрес

arp -d * - очистить таблицу ARP


# Домашнее задание к занятию "3.8. Компьютерные сети, лекция 3"

1   Подключитесь к публичному маршрутизатору в интернет. Найдите маршрут к вашему публичному IP

![image](https://user-images.githubusercontent.com/111060072/191812645-336d0700-ca6a-460e-9efa-baba91d85ce9.png)

2   Создайте dummy0 интерфейс в Ubuntu. Добавьте несколько статических маршрутов. Проверьте таблицу маршрутизации.

Создание инт-са 

sudo ip link add dummy0 type dummy

Добавление статических маршрутов

![image](https://user-images.githubusercontent.com/111060072/191819916-987e9fd8-855b-4b32-b666-5368e0699c87.png)

3   Проверьте открытые TCP порты в Ubuntu, какие протоколы и приложения используют эти порты? Приведите несколько примеров.

root@vagrant:/home/vagrant# ss -tulpn
Netid  State      Recv-Q     Send-Q          Local Address:Port              Peer Address:Port           Process
udp   UNCONN   0    0                      127.0.0.53%lo:53                      0.0.0.0:*                  users:(("systemd-resolve",pid=675,fd=12))
udp   UNCONN   0    0                      10.0.2.15%eth0:68                     0.0.0.0:*                  users:(("systemd-network",pid=673,fd=19))
tcp   LISTEN  0     4096                   127.0.0.53%lo:53                      0.0.0.0:*                  users:(("systemd-resolve",pid=675,fd=13))
tcp   LISTEN  0     128                    0.0.0.0:22                            0.0.0.0:*                  users:(("sshd",pid=764,fd=3))
tcp   LISTEN  0     128                    [::]:22                               [::]:*                     users:(("sshd",pid=764,fd=4))

         tcp
         22 - ssh порт
4   Проверьте используемые UDP сокеты в Ubuntu, какие протоколы и приложения используют эти порты?

         udp 
         53-dns порт 
         
5 Используя diagrams.net, создайте L3 диаграмму вашей домашней сети или любой другой сети, с которой вы работали.

![image](https://user-images.githubusercontent.com/111060072/191830341-55466fee-618a-4f8a-af4f-5a702f166056.png)























