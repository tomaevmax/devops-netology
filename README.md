# Домашнее задание к занятию 7 «Жизненный цикл ПО»   

## Основная часть   

Необходимо создать собственные workflow для двух типов задач: bug и остальные типы задач. Задачи типа bug должны проходить жизненный цикл:   
```
Open -> On reproduce.
On reproduce -> Open, Done reproduce.
Done reproduce -> On fix.
On fix -> On reproduce, Done fix.
Done fix -> On test.
On test -> On fix, Done.
Done -> Closed, Open.
```   
<details>
<summary>Ответ</summary>
<br>

![Снимок экрана 2023-07-30 в 08 56 42](https://github.com/tomaevmax/devops-netology/assets/32243921/a9d5f182-03c9-464d-b3c7-5ec76d11472c)

</details>   

Остальные задачи должны проходить по упрощённому workflow:   
```
Open -> On develop.
On develop -> Open, Done develop.
Done develop -> On test.
On test -> On develop, Done.
Done -> Closed, Open.
```   
<details>
<summary>Ответ</summary>
<br>
  
![Снимок экрана 2023-07-30 в 08 56 58](https://github.com/tomaevmax/devops-netology/assets/32243921/fc7e5452-e748-480f-8b14-9aa5d41a6a82)
</details>


##  Что нужно сделать

Создайте задачу с типом bug, попытайтесь провести его по всему workflow до Done.   
Создайте задачу с типом epic, к ней привяжите несколько задач с типом task, проведите их по всему workflow до Done.   
При проведении обеих задач по статусам используйте kanban.   
<details>
<summary>Создаем задачи и таски</summary>
<br>

![Снимок экрана 2023-07-30 в 08 33 32](https://github.com/tomaevmax/devops-netology/assets/32243921/796b5268-21c9-4def-bc83-3353f7e448cd)
</details>   

<details>
<summary>Доводим до сотояния готово</summary>
<br>

![gotovo kanban](https://github.com/tomaevmax/devops-netology/assets/32243921/2e57903d-b57c-4424-b267-1b3f1e0c1b9f)
</details>   

Верните задачи в статус Open.   
Перейдите в Scrum, запланируйте новый спринт, состоящий из задач эпика и одного бага, стартуйте спринт, проведите задачи до состояния Closed. Закройте спринт.   
Если всё отработалось в рамках ожидания — выгрузите схемы workflow для импорта в XML. Файлы с workflow и скриншоты workflow приложите к решению задания.   

<details>
<summary>Создаем задачи и таски</summary>
<br>

![Снимок экрана 2023-07-30 в 08 33 32](https://github.com/tomaevmax/devops-netology/assets/32243921/796b5268-21c9-4def-bc83-3353f7e448cd)
</details>






Ваша цель — написать собственный module, который вы можете использовать в своей role через playbook. Всё это должно быть собрано в виде collection и отправлено в ваш репозиторий.

**Шаг 1.** В виртуальном окружении создайте новый `my_own_module.py` файл.

**Шаг 2.** Наполните его содержимым:

**Шаг 3.** Заполните файл в соответствии с требованиями Ansible так, чтобы он выполнял основную задачу: module должен создавать текстовый файл на удалённом хосте по пути, определённом в параметре `path`, с содержимым, определённым в параметре `content`.

<details>
<summary>Ответ</summary>
<br>

[my_own_module.py](https://github.com/tomaevmax/my_own_collection/blob/main/yandex_cloud_elk/plugins/modules/my_own_module.py)
</details>

**Шаг 4.** Проверьте module на исполняемость локально.

<details>
<summary>Ответ</summary>
<br>

![Снимок экрана 2023-07-21 в 07 52 19](https://github.com/tomaevmax/devops-netology/assets/32243921/d800c4c6-653a-455a-9282-5428e8a5d142)

</details>

**Шаг 5.** Напишите single task playbook и используйте module в нём.

<details>
<summary>Ответ</summary>
<br>

````
---
- name: Testing my module
  hosts: localhost
  gather_facts: false
  tasks: 
    - name: Run my module
      my_own_module:
        path: "/Users/maksimtomaev/Downloads/repa/ansible/test.txt"
        content: "Hello, my freind!\n"
````
</details>

**Шаг 6.** Проверьте через playbook на идемпотентность.

<details>
<summary>Ответ</summary>
<br>

![Снимок экрана 2023-07-21 в 09 05 35](https://github.com/tomaevmax/devops-netology/assets/32243921/6828dc69-a627-47de-9e3c-f2aa8eb9ba43)


</details>

**Шаг 7.** Выйдите из виртуального окружения.

**Шаг 8.** Инициализируйте новую collection: `ansible-galaxy collection init my_own_namespace.yandex_cloud_elk`.

<details>
<summary>Ответ</summary>
<br>

````
ansible git:(devel) ✗ ansible-galaxy collection init my_own_namespace.yandex_cloud_elk
[WARNING]: You are running the development version of Ansible. You should only run Ansible from "devel" if you are modifying the Ansible engine, or trying out features under development. This is a rapidly changing source of code and can become unstable at any point.
- Collection my_own_namespace.yandex_cloud_elk was created successfully
````
</details>

**Шаг 9.** В эту collection перенесите свой module в соответствующую директорию.

<details>
<summary>Ответ</summary>
<br>

````
ansible git:(devel) ✗ cp my_own_module.py my_own_namespace/yandex_cloud_elk/plugins/modules 
````
</details>

**Шаг 10.** Single task playbook преобразуйте в single task role и перенесите в collection. У role должны быть default всех параметров module.

<details>
<summary>Ответ</summary>
<br>

[my_role](https://github.com/tomaevmax/my_own_collection/tree/main/yandex_cloud_elk/roles/my_role)
</details>

**Шаг 11.** Создайте playbook для использования этой role.

<details>
<summary>Ответ</summary>
<br>

[test_module_playbook.yml](https://github.com/tomaevmax/my_own_collection/blob/main/yandex_cloud_elk/test_module_playbook.yml)
</details>

**Шаг 12.** Заполните всю документацию по collection, выложите в свой репозиторий, поставьте тег `1.0.0` на этот коммит.

<details>
<summary>Ответ</summary>
<br>

[tag/1.0.0](https://github.com/tomaevmax/my_own_collection/releases/tag/1.0.0)   
[README.md](https://github.com/tomaevmax/my_own_collection/blob/main/yandex_cloud_elk/README.md)   
</details>

**Шаг 13.** Создайте .tar.gz этой collection: `ansible-galaxy collection build` в корневой директории collection.

<details>
<summary>Ответ</summary>
<br>

````
 yandex_cloud_elk git:(main) ansible-galaxy collection build
[WARNING]: You are running the development version of Ansible. You should only run Ansible from "devel" if you are modifying the Ansible engine, or trying out features under development. This is a rapidly changing source of code and can become unstable at any point.
Created collection for my_own_namespace.yandex_cloud_elk at /Users/maksimtomaev/Downloads/repa/ansible/my_own_namespace/yandex_cloud_elk/my_own_namespace-yandex_cloud_elk-1.0.0.tar.gz
````
</details>

**Шаг 14.** Создайте ещё одну директорию любого наименования, перенесите туда single task playbook и архив c collection.

**Шаг 15.** Установите collection из локального архива: `ansible-galaxy collection install <archivename>.tar.gz`.

<details>
<summary>Ответ</summary>
<br>

![Снимок экрана 2023-07-21 в 09 03 37](https://github.com/tomaevmax/devops-netology/assets/32243921/82847b54-6971-4282-a699-b2c28c506b44)

</details>

**Шаг 16.** Запустите playbook, убедитесь, что он работает.

<details>
<summary>Ответ</summary>
<br>

![Снимок экрана 2023-07-21 в 09 04 57](https://github.com/tomaevmax/devops-netology/assets/32243921/b948ad50-d468-4ac2-b523-427e4ceba123)

</details>

**Шаг 17.** В ответ необходимо прислать ссылки на collection и tar.gz архив, а также скриншоты выполнения пунктов 4, 6, 15 и 16.

<details>
<summary>Ответ</summary>
<br>

[my_own_collection](https://github.com/tomaevmax/my_own_collection/tree/main/yandex_cloud_elk)   
[tat.gz](my_own_namespace-yandex_cloud_elk-1.0.0.tar.gz)   

</details>
