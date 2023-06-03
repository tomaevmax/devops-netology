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
