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




