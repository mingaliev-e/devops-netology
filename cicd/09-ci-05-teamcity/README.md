# Домашнее задание к занятию 11 «Teamcity»

1) Настроил сервера teamcity-server и teamcity-agent
2) Авторизовал агента

![image](https://user-images.githubusercontent.com/111060072/225688196-73763153-6de7-44ec-8e42-6bf7ee0da062.png)

Настроил сервер Nexus

3) Создал новый проект в teamcity на основе fork и запустил сборку по master. 

![image](https://user-images.githubusercontent.com/111060072/225689001-4d676db7-3b78-4d46-a1e0-2d587adedd4f.png)

5) Поменял условия сборки: если сборка по ветке master, то должен происходит mvn clean deploy, иначе mvn clean test

![image](https://user-images.githubusercontent.com/111060072/225689320-fa5c85a1-3d5b-40d5-99a9-fccf537b31e6.png)

Загрузил settings.xml в набор конфигураций maven у teamcity, предварительно записав туда креды для подключения к nexus.

![image](https://user-images.githubusercontent.com/111060072/225690964-2b086612-fd8b-4628-8bde-132ecf4505a4.png)

5) Артефакт появтился в Nexus 

![image](https://user-images.githubusercontent.com/111060072/225691201-06b590a4-28cb-4f6c-ade5-2084ea979fb7.png)

6) Создал отдельную ветку feature/add_reply в репозитории.
7) Внес изменения с сделал push
8) Сборка запустилась автоматически 

![image](https://user-images.githubusercontent.com/111060072/225692292-ad0808c4-f440-4785-b69e-c5f376a07bba.png)

Внес изменения из произвольной ветки feature/add_reply в master через Merge
Запустил сборку по master снова

В Nexus появился новый артефакт 
![image](https://user-images.githubusercontent.com/111060072/225694804-956ffa39-d463-4321-b803-757a5127f60f.png)

Ссылка на репозиторий https://github.com/mingaliev-e/example-teamcity/tree/feature/add_reply
