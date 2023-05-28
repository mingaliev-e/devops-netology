# Домашнее задание к занятию «Микросервисы: подходы»

Вы работаете в крупной компании, которая строит систему на основе микросервисной архитектуры. 
Вам как DevOps-специалисту необходимо выдвинуть предложение по организации инфраструктуры для разработки и эксплуатации.

## Задача 1: Обеспечить разработку

Для решения задачи обеспечения процесса разработки в микросервисной архитектуре, я предлагаю использовать инструменты, которые называются CI/CD - Continuous Integration/Continuous Deployment.

Для таких инструментов обычно нужна облачная система, здесь можно использовать Amazon Web Services (AWS) или Google Cloud Platform (GCP). Обе компании предоставляют широкий спектр сервисов, которые могут использоваться для CI/CD.

Для системы контроля версий Git используются GitHub или GitLab. В обоих случаях, когда новый коммит попадает в ветку, происходит запуск сборки на CI-сервере.

Каждый сервис будет иметь свой репозиторий. После каждого изменения кода происходит автоматическая сборка образа Docker и публикация его в Docker Registry.

Для сборки проекта я предлагаю использовать систему сборки Jenkins. Она наиболее универсальна и найдет применение с любыми инструментами, которые надо будет использовать.

Jenkins развернут на отдельном сервере, на который будут прокидываться входящие запросы (hooks) от GitHub или GitLab. Также будут прокидываться параметры (например, тип сборки), которые указывают, какую сборку нужно сделать.

Настройки каждой сборки хранятся в файле Jenkinsfile в репозитории каждого сервиса, что обеспечивает возможность настройки сборок под каждый сервис.

Также планируется создание шаблонов для различных конфигураций сборок и возможность привязки настроек к каждой сборке.

Для безопасного хранения секретных данных будут использоваться Vault или KMS.

Кастомные шаги при сборке могут включать выполнение локальных скриптов или отправка сообщений в Slack или Telegram.

В итоге, с использованием такой инфраструктуры, мы сможем ускорить процесс разработки и улучшить качество кода, обеспечить быстрый запуск приложения на продакшене и возможность быстрого отката на предыдущую версию приложения в случае каких-то проблем.

## Задача 2: Логи


Для обеспечения сбора и анализа логов сервисов в микросервисной архитектуре, я предлагаю использовать систему логирования Elasticsearch, Logstash и Kibana (ELK-стек).

Для сбора логов на каждом хосте, где работает сервис, мы будем использовать библиотеку для логирования логов в формате JSON и отправки их в Logstash. Таким образом, логи будут отправляться на центральный хранилище в едином формате.

Logstash будет использоваться для сбора, обработки и передачи лог-данных в Elasticsearch. В Logstash мы можем настроить фильтры, которые обрабатывают данные лога до передачи их в Elasticsearch. Например, мы можем добавлять поля и метаданные в лог-записи, прежде чем они попадут в хранилище.

Elasticsearch будет использоваться в качестве центрального хранилища для лог-данных. Он обеспечивает поиск и фильтрацию по записям логов и индексацию данных. Elasticsearch предоставляет мощный поиск по тексту и возможность использовать запросы на языке запросов Elasticsearch DSL.

Для пользовательского интерфейса и предоставления доступа разработчикам предлагаю использовать Kibana.

Также Kibana предоставляет возможность сохранять поисковые запросы и фильтры, чтобы пользователи могли быстро находить необходимые данные.

В итоге, использование ELK-стека обеспечит нам минимальные требования к приложениям, гарантированную доставку логов до центрального хранилища, поиск и фильтрацию по записям логов, возможность предоставления доступа разработчикам и ссылку на сохранённый поиск по записям логов.

## Задача 3: Мониторинг


Для обеспечения сбора и анализа состояния хостов и сервисов в микросервисной архитектуре, я предлагаю использовать инструменты для мониторинга Prometheus, Grafana и Node Exporter.

Node Exporter будет использоваться для сбора метрик состояния ресурсов хостов и сервисов. Node Exporter - это агент, который собирает метрики из различных источников на хосте, включая CPU, RAM, HDD, сетевые интерфейсы и другие системные параметры.

Prometheus будет использоваться для сбора метрик из Node Exporter, а также для сбора метрик, специфических для каждого сервиса. Prometheus позволяет настраивать мониторинг и алертинг на основе метрик. Он использует язык запросов Prometheus PromQL для запросов метрик и их агрегации.

Grafana будет использоваться для пользовательского интерфейса и агрегирования информации. С помощью Grafana можно создавать дашборды и контролировать состояние системы на основе метрик, собранных Prometheus. Графические панели, создаваемые в Grafana, позволяют отследить множество параметров, а также историю изменения метрик и выполнить над ними разное агрегирование.

Также можно использовать Grafana для настройки алертинга на основе метрик, чтобы получать уведомления о потенциальных проблемах в системе.

Использование инструментов для мониторинга, таких как Prometheus, Grafana и Node Exporter, обеспечит сбор метрик со всех хостов и сервисов, метрик состояния ресурсов хостов: CPU, RAM, HDD, Network, сбор метрик потребляемых ресурсов для каждого сервиса: CPU, RAM, HDD, Network, а также сбор метрик, специфичных для каждого сервиса. Кроме того, инструменты для мониторинга предоставят пользовательский интерфейс с возможностью делать запросы и агрегировать информацию, пользовательский интерфейс с возможностью настраивать различные панели для отслеживания состояния системы.