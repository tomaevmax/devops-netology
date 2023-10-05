# Домашнее задание к занятию «Микросервисы: подходы»

Вы работаете в крупной компании, которая строит систему на основе микросервисной архитектуры.
Вам как DevOps-специалисту необходимо выдвинуть предложение по организации инфраструктуры для разработки и эксплуатации.


## Задача 1: Обеспечить разработку

Предложите решение для обеспечения процесса разработки: хранение исходного кода, непрерывная интеграция и непрерывная поставка. 
Решение может состоять из одного или нескольких программных продуктов и должно описывать способы и принципы их взаимодействия.

Решение должно соответствовать следующим требованиям:
- облачная система;
- система контроля версий Git;
- репозиторий на каждый сервис;
- запуск сборки по событию из системы контроля версий;
- запуск сборки по кнопке с указанием параметров;
- возможность привязать настройки к каждой сборке;
- возможность создания шаблонов для различных конфигураций сборок;
- возможность безопасного хранения секретных данных (пароли, ключи доступа);
- несколько конфигураций для сборки из одного репозитория;
- кастомные шаги при сборке;
- собственные докер-образы для сборки проектов;
- возможность развернуть агентов сборки на собственных серверах;
- возможность параллельного запуска нескольких сборок;
- возможность параллельного запуска тестов.

Обоснуйте свой выбор.   

<details>
<summary>Ответ</summary>
<br>

В целом все современные популярные решения для процесса разработки +/- обеспечивают требования предъявляемые к системе.

Это такие системы как:
- GitLab Ci/CD, для использования собственных докер образов можно использовать docker hub или artifactory
- Azure DevOps Services, для использования собственных докер образов можно использовать docker hub или artifactory
- TeamCity, но помимо использования отдельного хранилища для собственных образов необходимо подключать и системы 
контроля версий, например GitHub.

На основе свое опыта работы, я бы предложил использовать Gitlab Ci/CD, имеет наибольшую гибкость в настройке процессов и позволяет 
управлять и использовать все необходимые инструменты в одном окружении.


</details>    

## Задача 2: Логи   

Предложите решение для обеспечения сбора и анализа логов сервисов в микросервисной архитектуре.   
Решение может состоять из одного или нескольких программных продуктов и должно описывать способы и принципы их взаимодействия.   

Решение должно соответствовать следующим требованиям:   
- сбор логов в центральное хранилище со всех хостов, обслуживающих систему;  
- минимальные требования к приложениям, сбор логов из stdout;   
- гарантированная доставка логов до центрального хранилища;   
- обеспечение поиска и фильтрации по записям логов;   
- обеспечение пользовательского интерфейса с возможностью предоставления доступа разработчикам для поиска по записям логов;   
- возможность дать ссылку на сохранённый поиск по записям логов.   

Обоснуйте свой выбор.    

<details>
<summary>Ответ</summary>
<br>   

На мой взгляд лучшим решением будет стек ELK. 

Состав:
FileBeat - агент, собирающий данные с машины и направляющий в Logstash.   
Logstash - служба орабатывающая данные: фильтрует, парсит на составляющие поля, агрегирует строки, обогащает данные при необходимости и т.п. передает данные в системы потребители при необходимости.   
Elasticsearch - инструмент аналитики и полнотекстового поиска, позволяет хранить, оперативно получать нужные данные больших объемов.   
Kibana - Web визуальный инструмент для Elasticsearch, позволяет управлять индексами Elasticsearch, выполнять непосредственный визуальный поиск, строить Dashbord-ы для удобства оперативного анализа логов (данных).         

</details>    

## Задача 3: Мониторинг   

Предложите решение для обеспечения сбора и анализа состояния хостов и сервисов в микросервисной архитектуре.   
Решение может состоять из одного или нескольких программных продуктов и должно описывать способы и принципы их взаимодействия.   

Решение должно соответствовать следующим требованиям:   
- сбор метрик со всех хостов, обслуживающих систему;   
- сбор метрик состояния ресурсов хостов: CPU, RAM, HDD, Network;   
- сбор метрик потребляемых ресурсов для каждого сервиса: CPU, RAM, HDD, Network;   
- сбор метрик, специфичных для каждого сервиса;   
- пользовательский интерфейс с возможностью делать запросы и агрегировать информацию;   
- пользовательский интерфейс с возможностью настраивать различные панели для отслеживания состояния системы.   

Обоснуйте свой выбор.   

<details>
<summary>Ответ</summary>
<br>   

На мой взгляд лучшим решением будет связка Prometheus + Grafana.   

- Prometheus с его многочисленными exporter позволит собирать и хранить метрики с чего угодно дополняя их своими 
кастомными метриками, а при необходимости можно написать свой exporter
- Grafana - это мощное средство визуализации метрик хранящихся в Prometheus, позволяющее создавать свои панели и 
дашборды, или даже подобрать готовые. Так же Grafana позволяет настроить нотификации при возникновении предупреждений 
и включать в них снимки панелей, что бы наглядно видеть проблему не посещая саму систему

Преимущества:    
- красивая визуализация(Grafana)   
- широкоизвестный стек   
- большое количество собираемых метрик   
- Удобный UI.    

</details>  
