# Домашнее задание к занятию 4 «Работа с roles»

## Задача
1. Создайте в старой версии playbook файл requirements.yml и заполните его содержимым:   

## Ответ
[requirements.yml](/playbook/requirements.yml) 

## Задача   
2. При помощи ansible-galaxy скачайте себе эту роль.   

## Ответ    
````
 playbook git:(ansible-dz4) ✗ ansible-galaxy install -r requirements.yml -p roles
Starting galaxy role install process
- extracting clickhouse to /Users/maksimtomaev/Downloads/repa/devops-netology/playbook/roles/clickhouse
- clickhouse (1.11.0) was installed successfully

````

## Задача   
3. Создайте новый каталог с ролью при помощи ansible-galaxy role init vector-role.   

## Ответ    
````   
 playbook git:(ansible-dz4) ✗ ansible-galaxy role init vector-role --init-path roles   
- Role vector-role was created successfully   
````   
## Задача  
4. На основе tasks из старого playbook заполните новую role. Разнесите переменные между vars и default.
5. Перенести нужные шаблоны конфигов в templates.  

## Ответ    
[default](https://github.com/tomaevmax/vector-role/blob/master/defaults/main.yml)   
[vars](https://github.com/tomaevmax/vector-role/blob/master/vars/main.yml)   

## Задача  
6. Опишите в README.md обе роли и их параметры. Пример качественной документации ansible role по ссылке.   

## Ответ
[README.md](https://github.com/tomaevmax/vector-role/blob/master/README.md)

## Задача  
7. Повторите шаги 3–6 для LightHouse. Помните, что одна роль должна настраивать один продукт.

## Ответ   
[README.md](https://github.com/tomaevmax/lighthouse-role/blob/master/README.md)   

## Задача  
8. Выложите все roles в репозитории. Проставьте теги, используя семантическую нумерацию. Добавьте roles в requirements.yml в playbook.   

## Ответ  
[vector-role repa](https://github.com/tomaevmax/vector-role)  
[lighthouse-role repa](https://github.com/tomaevmax/lighthouse-role/tree/master)  
[requirements](playbook/requirements.yml)   

## Задача  
9. Переработайте playbook на использование roles. Не забудьте про зависимости LightHouse и возможности совмещения roles с tasks.   

## Ответ  
[playbook](playbook/site.yml)   

## Задача  
Выложите playbook в репозиторий.
В ответе дайте ссылки на оба репозитория с roles и одну ссылку на репозиторий с playbook.   

## Ответ  
[vector-role repa](https://github.com/tomaevmax/vector-role)  
[lighthouse-role repa](https://github.com/tomaevmax/lighthouse-role)  
[playbook repa](https://github.com/tomaevmax/devops-netology/tree/ansible-dz4)
