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
Импортируйте его обратно. Проверьте terraform plan - изменений быть не должно. Приложите список выполненных команд и вывод.   

Ответ:    

[disk-vm.tf](/src/disk_vm.tf)  
```   
 yandex_vpc_network.develop: Creating...
yandex_compute_disk.dynamic-hdd[0]: Creating...
yandex_compute_disk.dynamic-hdd[2]: Creating...
yandex_compute_disk.dynamic-hdd[1]: Creating...
yandex_vpc_network.develop: Creation complete after 2s [id=enp3v0l9st79etqaih16]
yandex_vpc_subnet.develop: Creating...
yandex_vpc_security_group.example: Creating...
yandex_vpc_subnet.develop: Creation complete after 0s [id=e9b42duvqqn3bvecehnc]
yandex_compute_instance.database: Creating...
yandex_compute_instance.example[1]: Creating...
yandex_compute_instance.example[0]: Creating...
yandex_compute_instance.platform: Creating...
yandex_vpc_security_group.example: Creation complete after 0s [id=enp1prtgg352hmb5n2o9]
yandex_compute_disk.dynamic-hdd[2]: Creation complete after 7s [id=fhm5aejcrsdrts4lmemc]
yandex_compute_disk.dynamic-hdd[0]: Creation complete after 9s [id=fhmh8anvv9esihjsbcjf]
yandex_compute_disk.dynamic-hdd[1]: Creation complete after 10s [id=fhm25173n4rik3mjau1h]
yandex_compute_instance.dinamic-disks: Creating...
yandex_compute_instance.example[1]: Still creating... [10s elapsed]
yandex_compute_instance.database: Still creating... [10s elapsed]
yandex_compute_instance.example[0]: Still creating... [10s elapsed]
yandex_compute_instance.platform: Still creating... [10s elapsed]
yandex_compute_instance.dinamic-disks: Still creating... [10s elapsed]
yandex_compute_instance.example[1]: Still creating... [20s elapsed]
yandex_compute_instance.database: Still creating... [20s elapsed]
yandex_compute_instance.example[0]: Still creating... [20s elapsed]
yandex_compute_instance.platform: Still creating... [20s elapsed]
yandex_compute_instance.dinamic-disks: Still creating... [20s elapsed]
yandex_compute_instance.example[0]: Still creating... [30s elapsed]
yandex_compute_instance.platform: Still creating... [30s elapsed]
yandex_compute_instance.database: Still creating... [30s elapsed]
yandex_compute_instance.example[1]: Still creating... [30s elapsed]
yandex_compute_instance.example[0]: Creation complete after 31s [id=fhmlos49v9no9u8lggph]
yandex_compute_instance.database: Creation complete after 32s [id=fhm33fka14uevr0hl03c]
yandex_compute_instance.platform: Creation complete after 34s [id=fhmtmvovc1497f4phrdh]
yandex_compute_instance.example[1]: Creation complete after 36s [id=fhm89b6ms8glo4mt4tdn]
yandex_compute_instance.test_for["0"]: Creating...
yandex_compute_instance.test_for["1"]: Creating...
yandex_compute_instance.dinamic-disks: Still creating... [30s elapsed]
yandex_compute_instance.dinamic-disks: Creation complete after 31s [id=fhmg69bd23669q8294q3]
yandex_compute_instance.test_for["0"]: Still creating... [10s elapsed]
yandex_compute_instance.test_for["1"]: Still creating... [10s elapsed]
yandex_compute_instance.test_for["1"]: Still creating... [20s elapsed]
yandex_compute_instance.test_for["0"]: Still creating... [20s elapsed]
yandex_compute_instance.test_for["0"]: Still creating... [30s elapsed]
yandex_compute_instance.test_for["1"]: Still creating... [30s elapsed]
yandex_compute_instance.test_for["0"]: Creation complete after 35s [id=fhm2re8iur7579ahiv4v]
yandex_compute_instance.test_for["1"]: Creation complete after 36s [id=fhmhv2l8dc1qhev2k8kr]

Apply complete! Resources: 13 added, 0 changed, 0 destroyed.

Outputs:

database_external_ip_address = "158.160.105.128"
platform_external_ip_address = "158.160.105.227"
  
```   
