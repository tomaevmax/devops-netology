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

[disk-vm.tf](/src/disk_vm.tf)  
```  
 terraform state list

```   
```  
 terraform state rm 'module.vpc_dev'

```   
```  
 terraform import 'module.vpc_dev.yandex_vpc_network.develop' enpfbes96a495cn0ejn4

```   
```  
 terraform import 'module.vpc_dev.yandex_vpc_subnet.develop' e9b5h9g371tvaubj6ebd 

```  
```  
 terraform plan

```   