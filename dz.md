# Домашнее задание к занятию "Управляющие конструкции в коде Terraform"»  

## Задача 1   

Изучите проект.
Заполните файл personal.auto.tfvars
Инициализируйте проект, выполните код (он выполнится даже если доступа к preview нет).
Примечание: Если у вас не активирован preview доступ к функционалу "Группы безопасности" в Yandex Cloud - запросите доступ у поддержки облачного провайдера. Обычно его выдают в течении 24-х часов.
Приложите скриншот входящих правил "Группы безопасности" в ЛК Yandex Cloud или скриншот отказа в предоставлении доступа к preview версии.   

Ответ:    
![Снимок экрана 2023-06-08 в 06 47 51](https://github.com/tomaevmax/devops-netology/assets/32243921/8b4fdc69-ac57-474f-9ec6-d9ba132407ba)

## Задача 2   

Создайте файл count-vm.tf. Опишите в нем создание двух одинаковых ВМ web-1 и web-2(не web-0 и web-1!), с минимальными параметрами, используя мета-аргумент count loop. Назначьте ВМ созданную в 1-м задании группу безопасности.
Создайте файл for_each-vm.tf. Опишите в нем создание 2 ВМ с именами "main" и "replica" разных по cpu/ram/disk , используя мета-аргумент for_each loop. Используйте переменную типа list(object({ vm_name=string, cpu=number, ram=number, disk=number })). При желании внесите в переменную все возможные параметры.
ВМ из пункта 2.2 должны создаваться после создания ВМ из пункта 2.1.
Используйте функцию file в local переменной для считывания ключа ~/.ssh/id_rsa.pub и его последующего использования в блоке metadata, взятому из ДЗ №2.
Инициализируйте проект, выполните код.  

Ответ:    

[count-vm.tf](/src/count-vm.tf)   
[for_each-vm.tf](/src/for_each-vm.tf)   

``` 
data.yandex_compute_image.ubuntu: Reading...
data.yandex_compute_image.ubuntu-2004-lts: Reading...
data.yandex_compute_image.ubuntu: Read complete after 1s [id=fd83vhe8fsr4pe98v6oj]
data.yandex_compute_image.ubuntu-2004-lts: Read complete after 1s [id=fd83vhe8fsr4pe98v6oj]

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

yandex_vpc_network.develop: Creating...
yandex_vpc_network.develop: Creation complete after 2s [id=enpgg29a7eqt2l6hsqus]
yandex_vpc_subnet.develop: Creating...
yandex_vpc_security_group.example: Creating...
yandex_vpc_subnet.develop: Creation complete after 0s [id=e9b8fk3nbcakfks3227m]
yandex_compute_instance.database: Creating...
yandex_compute_instance.example[0]: Creating...
yandex_compute_instance.example[1]: Creating...
yandex_compute_instance.platform: Creating...
yandex_vpc_security_group.example: Creation complete after 1s [id=enpr2ncjjmne9uvunu4g]
yandex_compute_instance.database: Still creating... [10s elapsed]
yandex_compute_instance.example[0]: Still creating... [10s elapsed]
yandex_compute_instance.example[1]: Still creating... [10s elapsed]
yandex_compute_instance.platform: Still creating... [10s elapsed]
yandex_compute_instance.database: Still creating... [20s elapsed]
yandex_compute_instance.example[1]: Still creating... [20s elapsed]
yandex_compute_instance.example[0]: Still creating... [20s elapsed]
yandex_compute_instance.platform: Still creating... [20s elapsed]
yandex_compute_instance.example[0]: Creation complete after 28s [id=fhmhq1a3nh4q5lc0ucp3]
yandex_compute_instance.example[1]: Still creating... [30s elapsed]
yandex_compute_instance.database: Still creating... [30s elapsed]
yandex_compute_instance.platform: Still creating... [30s elapsed]
yandex_compute_instance.database: Creation complete after 32s [id=fhmjkjjfce4gin7iat70]
yandex_compute_instance.platform: Creation complete after 32s [id=fhmkroh85mc5mgloi71m]
yandex_compute_instance.example[1]: Creation complete after 38s [id=fhmgqtc0utjkfj5phs9t]
yandex_compute_instance.test_for["0"]: Creating...
yandex_compute_instance.test_for["1"]: Creating...
yandex_compute_instance.test_for["0"]: Still creating... [10s elapsed]
yandex_compute_instance.test_for["1"]: Still creating... [10s elapsed]
yandex_compute_instance.test_for["1"]: Still creating... [20s elapsed]
yandex_compute_instance.test_for["0"]: Still creating... [20s elapsed]
yandex_compute_instance.test_for["0"]: Still creating... [30s elapsed]
yandex_compute_instance.test_for["1"]: Still creating... [30s elapsed]
yandex_compute_instance.test_for["0"]: Creation complete after 31s [id=fhmrn12qp608modjipnt]
yandex_compute_instance.test_for["1"]: Creation complete after 33s [id=fhm37hu2hitgmm3opots]

Apply complete! Resources: 9 added, 0 changed, 0 destroyed.

Outputs:

database_external_ip_address = "158.160.32.101"
platform_external_ip_address = "158.160.63.137"

```   
## Задача 3   
Создайте 3 одинаковых виртуальных диска, размером 1 Гб с помощью ресурса yandex_compute_disk и мета-аргумента count в файле disk_vm.tf .
Создайте в том же файле одну ВМ c именем "storage" . Используйте блок dynamic secondary_disk{..} и мета-аргумент for_each для подключения созданных вами дополнительных дисков.   

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