# Домашнее задание к занятию 9 «Процессы CI/CD»

Плейбук отработал корректно

    PLAY RECAP *******************************************************************************************************
    nexus-01                   : ok=17   changed=15   unreachable=0    failed=0    skipped=2    rescued=0    ignored=0
    sonar-01                   : ok=35   changed=27   unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

## Знакомоство с SonarQube

Тест прошел успешно, но с замечаниями

    INFO: ------------------------------------------------------------------------
    INFO: EXECUTION SUCCESS
    INFO: ------------------------------------------------------------------------
    INFO: Total time: 8.124s
    INFO: Final Memory: 8M/30M
    INFO: ------------------------------------------------------------------------


![image](https://user-images.githubusercontent.com/111060072/222223233-8d31aff9-2eb6-4bd0-8501-5ea1c5499d53.png)

Поправил скрипт 

![image](https://user-images.githubusercontent.com/111060072/222224811-66d2cc3c-9d40-4f92-b9e7-59861693f6e7.png)

## Знакомство с Nexus

![image](https://user-images.githubusercontent.com/111060072/222228805-ba984df1-4dc8-4035-b7ad-0233818970fa.png)

Файл maven-metadata.xml приложил в ответе к заданию

## Знакомство с Maven

    root@root:~# mvn --version
    Apache Maven 3.9.0 (9b58d2bad23a66be161c4664ef21ce219c2c8584)
    Maven home: /root/apache-maven-3.9.0
    Java version: 11.0.18, vendor: Ubuntu, runtime: /usr/lib/jvm/java-11-openjdk-amd64
    Default locale: en_US, platform encoding: UTF-8
    OS name: "linux", version: "5.15.0-60-generic", arch: "amd64", family: "unix"

Вывод команды mvn package

    [WARNING] JAR will be empty - no content was marked for inclusion!
    [INFO] Building jar: /root/devops-netology/cicd/09-ci-03-cicd/mvn/target/simple-app-1.0-SNAPSHOT.jar
    [INFO] ------------------------------------------------------------------------
    [INFO] BUILD SUCCESS
    [INFO] ------------------------------------------------------------------------
    [INFO] Total time:  14.664 s
    [INFO] Finished at: 2023-03-01T18:56:50Z
    [INFO] ------------------------------------------------------------------------

      
    root@root:~/devops-netology/cicd/09-ci-03-cicd/mvn# ll ~/.m2/repository/netology/java/8_282/
    total 20
    drwxr-xr-x 2 root root 4096 Mar  1 18:56 ./
    drwxr-xr-x 3 root root 4096 Mar  1 18:54 ../
    -rw-r--r-- 1 root root    0 Mar  1 18:56 java-8_282-distrib.tar.gz
    -rw-r--r-- 1 root root   40 Mar  1 18:56 java-8_282-distrib.tar.gz.sha1
    -rw-r--r-- 1 root root  731 Mar  1 18:56 java-8_282.pom.lastUpdated
    -rw-r--r-- 1 root root  175 Mar  1 18:56 _remote.repositories


