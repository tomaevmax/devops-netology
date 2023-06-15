# Домашнее задание к занятию "Продвинутые методы работы с Terraform"  

## Задача 1   

Возьмите из демонстрации к лекции готовый код для создания ВМ с помощью remote модуля.
Создайте 1 ВМ, используя данный модуль. В файле cloud-init.yml необходимо использовать переменную для ssh ключа вместо хардкода. Передайте ssh-ключ в функцию template_file в блоке vars ={} . Воспользуйтесь примером. Обратите внимание что ssh-authorized-keys принимает в себя список, а не строку!
Добавьте в файл cloud-init.yml установку nginx.
Предоставьте скриншот подключения к консоли и вывод команды sudo nginx -t.   

Ответ:    
![Снимок экрана 2023-06-14 в 06 49 24](https://github.com/tomaevmax/devops-netology/assets/32243921/2fce4051-bd9e-4c8b-bb7d-bbbacbc88c5c)


## Задача 2   

Напишите локальный модуль vpc, который будет создавать 2 ресурса: одну сеть и одну подсеть в зоне, объявленной при вызове модуля. например: ru-central1-a.
Модуль должен возвращать значения vpc.id и subnet.id
Замените ресурсы yandex_vpc_network и yandex_vpc_subnet, созданным модулем.
Сгенерируйте документацию к модулю с помощью terraform-docs.   

Ответ:    

[modul](/src/modules/vpc_dev)   
[docs](/src/modules/vpc_dev/docs.md)   


## Задача 3   

Выведите список ресурсов в стейте.  
Удалите из стейта модуль vpc.  
Импортируйте его обратно.   
Проверьте terraform plan - изменений быть не должно.   
Приложите список выполненных команд и вывод.   

Ответ:    

```  
 terraform state list

```   
![Снимок экрана 2023-06-15 в 06 47 11](https://github.com/tomaevmax/devops-netology/assets/32243921/c39e96ad-8a46-4b27-b6d1-0623a111b4d2)   

```  
 terraform state rm 'module.vpc_dev'

```   
![Снимок экрана 2023-06-15 в 06 54 19](https://github.com/tomaevmax/devops-netology/assets/32243921/11d1cdbf-1160-4d70-b79b-43ba81e89132)

```  
 terraform import 'module.vpc_dev.yandex_vpc_network.develop' enpfbes96a495cn0ejn4

```   
![Снимок экрана 2023-06-15 в 06 55 45](https://github.com/tomaevmax/devops-netology/assets/32243921/638e012b-6b5f-40f3-9bc4-376cfb5282b3)   

```  
 terraform import 'module.vpc_dev.yandex_vpc_subnet.develop' e9b5h9g371tvaubj6ebd 

```  
![Снимок экрана 2023-06-15 в 06 56 25](https://github.com/tomaevmax/devops-netology/assets/32243921/5ff35b19-1306-4832-9aff-414a101b7daa)

```  
 terraform plan

```   
![Снимок экрана 2023-06-15 в 06 56 38](https://github.com/tomaevmax/devops-netology/assets/32243921/39ffd465-05b1-48e6-beae-c8e4641f48c3)
