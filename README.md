# Домашнее задание по лекции "Операционные системы (лекция 1)"

1  Какой системный вызов делает команда cd?

chdir("/tmp")  = 0

2  Используя strace выясните, где находится база данных file, на основании которой она делает свои догадки.

         stat("/root/.magic.mgc", 0x7fff9191b940) = -1 ENOENT (Нет такого файла или каталога)
         stat("/root/.magic", 0x7fff9191b940)    = -1 ENOENT (Нет такого файла или каталога)
         openat(AT_FDCWD, "/etc/magic.mgc", O_RDONLY) = -1 ENOENT (Нет такого файла или каталога)
         stat("/etc/magic", {st_mode=S_IFREG|0644, st_size=111, ...}) = 0
         openat(AT_FDCWD, "/etc/magic", O_RDONLY) = 3
         fstat(3, {st_mode=S_IFREG|0644, st_size=111, ...}) = 0
         read(3, "# Magic local data for file(1) c"..., 4096) = 111
         read(3, "", 4096)                       = 0
         close(3)                                = 0
         openat(AT_FDCWD, "/usr/share/misc/magic.mgc", O_RDONLY) = 3

3  Предположим, приложение пишет лог в текстовый файл. Этот файл оказался удален (deleted в lsof), однако возможности сигналом сказать приложению переоткрыть файлы или просто перезапустить приложение – нет. Так как приложение продолжает писать в удаленный файл, место на диске постепенно заканчивается. Основываясь на знаниях о перенаправлении потоков предложите способ обнуления открытого удаленного файла (чтобы освободить место на файловой системе).

echo ""| sudo tee /proc/PID/fd/DESCRIPTOR

4  Занимают ли зомби-процессы какие-то ресурсы в ОС (CPU, RAM, IO)?

Зомби-процессы не занимают освобождают системные ресурсы, но сохраняют свой ID процесса

5  На какие файлы вы увидели вызовы группы open за первую секунду работы утилиты?

       [root@localhost admin]# /usr/sbin/opensnoop-bpfcc
       PID    COMM               FD ERR PATH
       766    vminfo              6   0 /var/run/utmp
       562    dbus-daemon        -1   2 /usr/local/share/dbus-1/system-services
       562    dbus-daemon        18   0 /usr/share/dbus-1/system-services
       562    dbus-daemon        -1   2 /lib/dbus-1/system-services
       562    dbus-daemon        18   0 /var/lib/snapd/dbus-1/system-services/

6  Какой системный вызов использует uname -a? Приведите цитату из man по этому системному вызову, где описывается альтернативное местоположение в /proc, где можно узнать версию ядра и релиз ОС.

системный вызов uname()

       Part of the utsname information is also accessible  via  /proc/sys/ker‐nel/{ostype, hostname, osrelease, version, domainname}.
       
 7  Чем отличается последовательность команд через ; и через && в bash? 
 
       ; - выполелнение команд последовательно
       && - команда после && выполняется только если команда до && завершилась успешно (статус выхода 0)

Если /tmp/some_dir не существует, то статус выхода не равен 0 и echo Hi не будет выполняться
  
set -e - останавливает выполнение команд при ошибке кроме последней команды

Если ошибочно завершится одна из команд, разделённых &&, то выхода из шелла не произойдёт. Так что, смысл есть.

8  Из каких опций состоит режим bash set -euxo pipefail и почему его хорошо было бы использовать в сценариях?

      -e  Exit immediately if a command exits with a non-zero status.
      -u  Treat unset variables as an error when substituting.
      -x  Print commands and their arguments as they are executed.
      -o pipefail     the return value of a pipeline is the status of
                           the last command to exit with a non-zero status,
                           or zero if no command exited with a non-zero status
Режим обеспечит прекращение выполнения скрипта в случае ошибок и выведет необходимую для информацию для исправления ошибки 

9  Используя -o stat для ps, определите, какой наиболее часто встречающийся статус у процессов в системе. В man ps ознакомьтесь (/PROCESS STATE CODES) что значат дополнительные к основной заглавной буквы статуса процессов. Его можно не учитывать при расчете (считать S, Ss или Ssl равнозначными).

Наиболее часто встречаются процессы с STAT = S, Ss или Ssl - (прерываемый сон), ожидающие дальнейшей команды/сигналов.

Here are the different values that the s, stat and state output specifiers (header "STAT" or "S") will display
       to describe the state of a process:

               D    uninterruptible sleep (usually IO)
               I    Idle kernel thread
               R    running or runnable (on run queue)
               S    interruptible sleep (waiting for an event to complete)
               T    stopped by job control signal
               t    stopped by debugger during the tracing
               W    paging (not valid since the 2.6.xx kernel)
               X    dead (should never be seen)
               Z    defunct ("zombie") process, terminated but not reaped by its parent

       For BSD formats and when the stat keyword is used, additional characters may be displayed:

               <    high-priority (not nice to other users)
               N    low-priority (nice to other users)
               L    has pages locked into memory (for real-time and custom IO)
               s    is a session leader
               l    is multi-threaded (using CLONE_THREAD, like NPTL pthreads do)
               +    is in the foreground process group

# Домашнее задание по лекции "Операционные системы (лекция 2)"

1  Используя знания из лекции по systemd, создайте самостоятельно простой unit-файл для node_exporter:

поместите его в автозагрузку, предусмотрите возможность добавления опций к запускаемому процессу через внешний файл (посмотрите, например, на systemctl cat cron), удостоверьтесь, что с помощью systemctl процесс корректно стартует, завершается, а после перезагрузки автоматически поднимается.

![image](https://user-images.githubusercontent.com/111060072/189930937-b87859d9-0bec-4d3f-8152-e7b3f3ebc5f5.png)

![image](https://user-images.githubusercontent.com/111060072/189931165-ac521640-6b52-43ab-bf60-a70c6a9b2a08.png)

Служба работает, автозагрузка работает, после ребута стартует 

2  Ознакомьтесь с опциями node_exporter и выводом /metrics по-умолчанию. Приведите несколько опций, которые вы бы выбрали для базового мониторинга хоста по CPU, памяти, диску и сети.

CPU

         node_cpu_seconds_total{cpu="0",mode="idle"}
         node_cpu_seconds_total{cpu="0",mode="system"}
         node_cpu_seconds_total{cpu="0",mode="user"}
         node_cpu_seconds_total{cpu="1",mode="idle"}
         node_cpu_seconds_total{cpu="1",mode="system"}
         node_cpu_seconds_total{cpu="1",mode="user"}

ОЗУ

         node_memory_MemAvailable_bytes
         node_memory_MemFree_bytes
         node_memory_Buffers_bytes
         node_memory_Cached_bytes
         
Диск sda

         node_disk_io_time_seconds_total{device="sda"}
         node_disk_read_time_seconds_total{device="sda"}
         node_disk_write_time_seconds_total{device="sda"}
         node_filesystem_avail_bytes
         
Сеть 

         node_network_info
         node_network_receive_bytes_total
         node_network_receive_errs_total
         node_network_transmit_bytes_total
         node_network_transmit_errs_total

3  Установите в свою виртуальную машину Netdata. Воспользуйтесь готовыми пакетами для установки (sudo apt install -y netdata). 

![image](https://user-images.githubusercontent.com/111060072/189946564-0d7217b6-1c27-45f5-8ca9-47e0581cfc25.png)

4  Можно ли по выводу dmesg понять, осознает ли ОС, что загружена не на настоящем оборудовании, а на системе виртуализации?

Можно 

![image](https://user-images.githubusercontent.com/111060072/189946946-3b091b27-0955-4492-b239-92b0c53ecd93.png)

5  Как настроен sysctl fs.nr_open на системе по-умолчанию? Узнайте, что означает этот параметр. Какой другой существующий лимит не позволит достичь такого числа (ulimit --help)?

sysctl fs.nr_open - Лимит на количество открытых дескрипторов ему же соответствует файл /proc/sys/fs/nr_open

         vagrant@vagrant:~$ sysctl fs.nr_open
         fs.nr_open = 1048576

но такой лимит недостижим, потому что 

         vagrant@vagrant:~$ ulimit -n
         1024

6  Запустите любой долгоживущий процесс (не ls, который отработает мгновенно, а, например, sleep 1h) в отдельном неймспейсе процессов; покажите, что ваш процесс работает под PID 1 через nsenter

![image](https://user-images.githubusercontent.com/111060072/189951452-5abdea0c-a357-4115-9b12-dc842fa32ce8.png)

7  Найдите информацию о том, что такое :(){ :|:& };:. Запустите эту команду в своей виртуальной машине Vagrant с Ubuntu 20.04 (это важно, поведение в других ОС не проверялось). Некоторое время все будет "плохо", после чего (минуты) – ОС должна стабилизироваться. Вызов dmesg расскажет, какой механизм помог автоматической стабилизации. Как настроен этот механизм по-умолчанию, и как изменить число процессов, которое можно создать в сессии?

это функция, которая параллельно пускает два своих экземпляра. Каждый пускает ещё по два и т.д.

можно записать иначе как:

         f() {
           f | f &
         }
         f
         
dmesg 

[ 2310.956271] cgroup: fork rejected by pids controller in /user.slice/user-1000.slice/session-4.scope

По умолчанию 
root@vagrant:/# ulimit -u
3554

изменить можно ulimit -u 700 













