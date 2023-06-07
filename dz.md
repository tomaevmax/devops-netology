# Домашнее задание к занятию «Основы Terraform. Yandex Cloud»  

## Задача 1   

Изучите проект. В файле variables.tf объявлены переменные для yandex provider.
Переименуйте файл personal.auto.tfvars_example в personal.auto.tfvars. Заполните переменные (идентификаторы облака, токен доступа). Благодаря .gitignore этот файл не попадет в публичный репозиторий. Вы можете выбрать иной способ безопасно передать секретные данные в terraform.
Сгенерируйте или используйте свой текущий ssh ключ. Запишите его открытую часть в переменную vms_ssh_root_key.
Инициализируйте проект, выполните код. Исправьте возникшую ошибку.  
Ответьте в чем заключается ее суть?
Ответьте, как в процессе обучения могут пригодиться параметрыpreemptible = true и core_fraction=5 в параметрах ВМ? Ответ в документации Yandex cloud.

Ответ:    

![Снимок экрана 2023-06-03 в 06 58 50](https://github.com/tomaevmax/devops-netology/assets/32243921/d105f1cc-8652-4ad7-a136-6f4e20a39b57)   

![Снимок экрана 2023-06-03 в 06 59 01](https://github.com/tomaevmax/devops-netology/assets/32243921/c58e717b-092e-47fb-8a1e-91fd17bb531e)  

В процессе применения плана возникла ошибка.

``` 
yandex_compute_instance.platform: Creating...   

Error: Error while requesting API to create instance: server-request-id = f9d7382f-5dbc-47d0-adb5-7db08cb3bed4 server-trace-id = 69afd10ad50d6ff1:ee536ba6a6bc3b53:69afd10ad50d6ff1:1 client-request-id = f4c34639-975d-4e48-8934-489f7bd1992c client-trace-id = 4860ad7f-7d93-460d-9067-74d3e70ada6c rpc error: code = InvalidArgument desc = the specified number of cores is not available on platform "standard-v1"; allowed core number: 2, 4   
```   
Суть ошибки состояти в тоv, что в яндек облаке для создаваемых VM нельзя указывать нечетное количество ядер.   
preemptible = true - полезная в целях экономии ресурсов, когда можно сразу определить каким vm можно пожертвовать при нехватки ресурсов.   
core_fraction=5 - сможет пригодится, когда потребуется запустить больше виртуалок с количеством ядер в настройках большем чем чем физически нам доступном.   

## Задание 2   
Изучите файлы проекта.   
Замените все "хардкод" значения для ресурсов yandex_compute_image и yandex_compute_instance на отдельные переменные. К названиям переменных ВМ добавьте в начало префикс vm_web_ . Пример: vm_web_name.   
Объявите нужные переменные в файле variables.tf, обязательно указывайте тип переменной. Заполните их default прежними значениями из main.tf.   
Проверьте terraform plan (изменений быть не должно).   

Ответ   
[variables.tf](/src/variables.tf)

## Задание 3   
Создайте в корне проекта файл 'vms_platform.tf' . Перенесите в него все переменные первой ВМ.   
Скопируйте блок ресурса и создайте с его помощью вторую ВМ(в файле main.tf): "netology-develop-platform-db" , cores = 2, memory = 2, core_fraction = 20. Объявите ее переменные с префиксом vm_db_ в том же файле('vms_platform.tf').   
Примените изменения.   

Ответ  

[vms_platform.tf](/src/vms_platform.tf)

## Задание 4   

Объявите в файле outputs.tf output типа map, содержащий { instance_name = external_ip } для каждой из ВМ.
Примените изменения.
В качестве решения приложите вывод значений ip-адресов команды terraform output   

Ответ:    
![ip_external](https://github.com/tomaevmax/devops-netology/assets/32243921/82011ba2-a7fd-406b-a550-1a090a7d8b42)

## Задание 5   
В файле locals.tf опишите в одном local-блоке имя каждой ВМ, используйте интерполяцию ${..} с несколькими переменными по примеру из лекции.   
Замените переменные с именами ВМ из файла variables.tf на созданные вами local переменные.   
Примените изменения.   

Ответ:  
[locals.tf](/src/locals.tf)
[variables.tf](/src/variables.tf)

## Задание 6   
Вместо использования 3-х переменных ".._cores",".._memory",".._core_fraction" в блоке resources {...}, объедените их в переменные типа map с именами "vm_web_resources" и "vm_db_resources".   
Так же поступите с блоком metadata {serial-port-enable, ssh-keys}, эта переменная должна быть общая для всех ваших ВМ.   
Найдите и удалите все более не используемые переменные проекта.   
Проверьте terraform plan (изменений быть не должно).   

Ответ: 
[vms_platform.tf](/src/vms_platform.tf)

## Задание 7*   

Изучите содержимое файла console.tf. Откройте terraform console, выполните следующие задания:

Напишите, какой командой можно отобразить второй элемент списка test_list?
Найдите длину списка test_list с помощью функции length(<имя переменной>).
Напишите, какой командой можно отобразить значение ключа admin из map test_map ?
Напишите interpolation выражение, результатом которого будет: "John is admin for production server based on OS ubuntu-20-04 with X vcpu, Y ram and Z virtual disks", используйте данные из переменных test_list, test_map, servers и функцию length() для подстановки значений.
В качестве решения предоставьте необходимые команды и их вывод.

Ответ: 
```   
> local.test_list[1]
"staging"   
```  
```  
> length(local.test_list)
3   
```  
``` 
> lookup(local.test_map, "admin", "not found")
"John"   
```   

