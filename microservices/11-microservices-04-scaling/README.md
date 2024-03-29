# Домашнее задание к занятию «Микросервисы: масштабирование»

Вы работаете в крупной компании, которая строит систему на основе микросервисной архитектуры. Вам как DevOps-специалисту необходимо выдвинуть предложение по организации инфраструктуры для разработки и эксплуатации.

Задача 1: Кластеризация

Для решения задачи кластеризации, наиболее оптимальным решением будет использование Kubernetes, как универсальной оркестрации контейнеров. Kubernetes предоставляет набор инструментов и функций для мониторинга, управления и автоматизации развертывания микросервисов в контейнерах.

Конкретно для обеспечения обнаружения сервисов и маршрутизации запросов Kubernetes использует сервисы, которые определяют наименование, IP-адреса и порты, обеспечивающие доступ к микросервисам в кластере. 
Для горизонтального масштабирования и автоматического масштабирования Kubernetes предоставляет возможность использования горизонтального подведения счета, расширения и автоматического масштабирования на основе правил автомасштабирования.

Для разделения доступных ресурсов наружу и внутри системы Kubernetes использует сервисы напрямую-политики сетевой безопасности. 
По умолчанию, поды в Kubernetes не могут напрямую общаться между собой, так что для коммуникации между ними используются сервисы.

Кроме этого, Kubernetes предоставляет возможность конфигурирования приложений с помощью переменных среды, которые могут содержать чувствительные данные, включая пароли, секреты и ключи шифрования. 
Kubernetes также обеспечивает безопасное хранение этих данных с помощью секретов Kubernetes.

Все эти функции Кubernetes позволяют нам получить гибкую, отказоустойчивую и масштабируемую инфраструктуру для разработки и эксплуатации микросервисов в условиях динамично меняющихся бизнес-требований.

