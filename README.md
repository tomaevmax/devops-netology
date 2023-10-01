# Домашнее задание к занятию «Микросервисы: принципы»   
 
Вы работаете в крупной компании, которая строит систему на основе микросервисной архитектуры.   
Вам как DevOps-специалисту необходимо выдвинуть предложение по организации инфраструктуры для разработки и эксплуатации.   

## Задача 1: API Gateway   

Предложите решение для обеспечения реализации API Gateway. Составьте сравнительную таблицу возможностей различных программных решений. На основе таблицы сделайте выбор решения.

Решение должно соответствовать следующим требованиям:   
- Маршрутизация запросов к нужному сервису на основе конфигурации   
- Возможность проверки аутентификационной информации в запросах   
- Обеспечение терминации HTTPS   

Обоснуйте свой выбор.   

<details>
<summary>Ответ</summary>
<br>

### Сравнительная таблица возможностей различных API Gateway   

| API geteway | Обеспечение терминации HTTPS | Возможность проверки аутентификационной информации в запросах | Маршрутизация запросов к нужному сервису на основе конфигурации | Итеграция с облаком |
| ------------- |:-------------|:-----|:---|:---|
| Amazon API Gateway |+|+|AWS Lambda|AWS|
| NGINX Plus |+|+|LUA|Any|
| NETFLIX Zuul |+|+|-|Any|
| Spring colud gateway |+|+|yml, code|Any|
| WSO2 API Manager |+|+|Web GUI/ CLI|Any|
| Kong Enterprise Edition |+|+|Plugins|Any|
| Apigee Edge Microgateway |+|+||Any|
| Red Hat 3scale APIcast API Gateway |+|+|Web GUI|Any|


Из информации полученной из открытых источников я могу сделать вывод, что в случае развертываения инфраструктуры в облаке наилучшим инструментом являются шлюзы,предоставляеме постащиком услуг (Amazon API gateway, sbercloud API gateway, Yandex.cloud API gateway и пр.) по причине наилучшей интерграции с другими сервисами, однако данные сервисы конфгурируются через веб интерфейс.   

В случае необходимости использования стороннего шлюза наиболе подходящими под требования задания выглядят NGINX Plus и Spring colud gateway.   

</details>    

## Задача 2: Брокер сообщений

Составьте таблицу возможностей различных брокеров сообщений. На основе таблицы сделайте обоснованный выбор решения.

Решение должно соответствовать следующим требованиям:
- Поддержка кластеризации для обеспечения надежности
- Хранение сообщений на диске в процессе доставки
- Высокая скорость работы
- Поддержка различных форматов сообщений
- Разделение прав доступа к различным потокам сообщений
- Протота эксплуатации

Обоснуйте свой выбор.   

<details>
<summary>Ответ</summary>
<br>   

| Параметр\Брокер | RabbitMQ | Apache Kafka | ActiveMQ | WebSphereMQ | 
|---|---|---|---|---|
| Поддержка кластеризации | + | + | + | + | 
| Хранение сообщений в процессе доставки | + | + | + | + | 
| Высокая скорость | - | + | - | + | 
| Поддержка различных форматов | + | + | - | + | 
| Разделение прав доступа | + | + | + | + |
| Простота эксплуатации | - | + | + | + | 

Основываясь на сравнении брокеров оптимально выбрать Kafka, так как у него наибольшее количество плюсов и большое коммьюнити.   

</details>    
