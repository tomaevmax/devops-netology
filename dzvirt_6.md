# Домашнее задание к занятию «Введение в Terraform»   

## Задача 1   

1. Перейдите в каталог src. Скачайте все необходимые зависимости, использованные в проекте.   

Ответ:   

![Выполняем init](https://github.com/tomaevmax/devops-netology/assets/32243921/3dac2804-dbfb-459c-ae2f-e72814e36e0f)   

2. Изучите файл .gitignore. В каком terraform файле согласно этому .gitignore допустимо сохранить личную, секретную информацию?   

Ответ:   

personal.auto.tfvars%    

3. Выполните код проекта. Найдите в State-файле секретное содержимое созданного ресурса random_password, пришлите в качестве ответа конкретный ключ и его значение.   

Ответ:   

random_string:  GdIb8owIOKq1saZy   

4. Раскомментируйте блок кода, примерно расположенный на строчках 29-42 файла main.tf. Выполните команду terraform validate. Объясните в чем заключаются намеренно допущенные ошибки? Исправьте их.   

Ответ:   

В обьявлении ресурса resource "docker_image" пропущен обязательный параметр уникальное имя в текущем проекте   
В обьявлении resource "docker_container" "1nginx" в уникальном имени указано цифра 1 , что не валидируется терраформ
В аргументе name  = "example_${random_password.random_string_fake.resuld}" указана не то уникальное имя, что создано ранее и не то имя для получения результата.   

5. Выполните код. В качестве ответа приложите вывод команды docker ps   

Ответ:   
![docker ps](https://github.com/tomaevmax/devops-netology/assets/32243921/4d6b3f61-37a9-4649-94ac-9440ff319542)   

6. Замените имя docker-контейнера в блоке кода на hello_world, выполните команду terraform apply -auto-approve. Объясните своими словами, в чем может быть опасность применения ключа  -auto-approve ? В качестве ответа дополнительно приложите вывод команды docker ps   

Ответ:    

Команда выполняется без апрува пользователя, из-за чего есть риск не увидит ошибки в коде, что может привести к потере ранее созданных ресурсов.
![docker ps](https://github.com/tomaevmax/devops-netology/assets/32243921/aa5ed694-4cac-4eab-928b-c20a0138f64d)

7. Уничтожьте созданные ресурсы с помощью terraform. Убедитесь, что все ресурсы удалены. Приложите содержимое файла terraform.tfstate.   

Ответ:   
![terraform state](https://github.com/tomaevmax/devops-netology/assets/32243921/54cce2b1-e88d-45f7-bedd-30daac3dd6fa)   

8. Объясните, почему при этом не был удален docker образ nginx:latest ? Ответ подкрепите выдержкой из документации провайдера.   

Ответ:   
При создании ресурса  resource "docker_image" был включен параметр keep_locally = true , согласно документации при выставленном в true образ не удаляется при операциии destroy.   
https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs/resources/image#keep_locally
