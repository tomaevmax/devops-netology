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
<summary>Отчет по спринту</summary>
<br>

![Снимок экрана 2023-07-30 в 08 45 57](https://github.com/tomaevmax/devops-netology/assets/32243921/a3f7d62e-40e2-4083-8219-61eb1a5aae10)
</details>

##  Схемы workflow   
[bug](bug.xml)   
[task](All%20task.xml)
