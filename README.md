1 cd - это встроенная команда и выполняется в той оболочке в которой запущена

![image](https://user-images.githubusercontent.com/111060072/188165507-87df1a02-cb60-4ef5-93f0-4470b9d776b2.png)

Если б она не была встроенной то при смене директории нам бы приходилось запускать новый процесс и вызвать bash и при этом бы создавалась новая сессия shell 

При каждом переходе запускался бы отдельный дочерний процесс

2 

![image](https://user-images.githubusercontent.com/111060072/188132364-9e7e64bf-0d5d-448f-8974-dec2c3e8e90e.png)

3 systemd

![image](https://user-images.githubusercontent.com/111060072/188132664-7c53a659-7fac-4d84-86de-3aa8e63907db.png)

4 ls -lh /opt > /dev/pts/1

5 Получится 

![image](https://user-images.githubusercontent.com/111060072/188139515-8b6b634c-9f62-4ac1-9e6a-8aa4c51e7fac.png)

6 Получится например командой sudo echo Hello >/dev/tty1

7 n>&m означает перенаправить FD n в те же места, что и FD m. Например, 2>&1 означает отправку STDERR в то же место, что и STDOUT.

STDIN — это FD 0, STDOUT — это FD 1, а STDERR — это FD 2.

т.е. bash 5>&1 - Создаст дескриптор 5 и перенатправит его в stdout

echo netology > /proc/$$/fd/5 - выведет в дескриптор "5" сообщение netology, которое будет пернеаправлено в stdout

В результате мы получим вывод 

      root@vagrant:/home/vagrant# echo netology > /proc/$$/fd/5
      netology

8 Получится. Для этого нужно поменять местами STDOUT и STDERR. например 6>&1 1>&2 2>&6

![image](https://user-images.githubusercontent.com/111060072/188159995-a28dffb1-ed5c-434c-9c66-574efa148c39.png)

9 cat /proc/$$/environ выведет переменные окружения 

их также можно вывести с помощью env в более удобном построчном виде 

10  /proc/<PID>/cmdline - полный путь до исполняемого файла процесса
    
    /proc/<PID>/exe - символическая ссылка содержащая фактический путь к выполняемому процессу

11 sse4_2

        root@vagrant:/home/vagrant# cat /proc/cpuinfo | grep sse
        flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx rdtscp lm constant_tsc rep_good nopl xtopology nonstop_tsc cpuid tsc_known_freq pni pclmulqdq ssse3 cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx rdrand hypervisor lahf_lm abm 3dnowprefetch invpcid_single pti fsgsbase avx2 invpcid rdseed clflushopt md_clear flush_l1d
        flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx rdtscp lm constant_tsc rep_good nopl xtopology nonstop_tsc cpuid tsc_known_freq pni pclmulqdq ssse3 cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx rdrand hypervisor lahf_lm abm 3dnowprefetch invpcid_single pti fsgsbase avx2 invpcid rdseed clflushopt md_clear flush_l1d
        root@vagrant:/home/vagrant#

12 При подключении по ssh TTY не выделяется для удаленного сеанса. Можно использовать принудительное открытие терминала командой ssh -t localhost 'tty' -t

13 Установил reptyr командой sudo apt install reptyr далее ввел kernel.yama.ptrace_scope = 0 и выполнил задание 

14  echo команда для вывода информации, таким образом при команде sudo echo string > /root/new_file права sudo распрастраняются только на echo, но не на запись в файл в данной директории, команда tee записывает в файл и при команде echo string | sudo tee /root/new_file права sudo на выполение echo необязательны, а на tee как раз обязательны и такаая команда отработает верно. 
