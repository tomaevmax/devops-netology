# Домашнее задание к занятию 11 «Teamcity»   

## Основная часть   

1. Создайте новый проект в teamcity на основе fork.

<details>
<summary>Ответ</summary>
<br>

![Снимок экрана 2023-08-16 в 06 37 04](https://github.com/tomaevmax/devops-netology/assets/32243921/0ceee069-9120-49ff-99c3-5f9ae93748f2)   

![Снимок экрана 2023-08-16 в 06 39 44](https://github.com/tomaevmax/devops-netology/assets/32243921/f701d2f9-5301-490e-a02a-303f27819004)


</details>  

2. Сделайте autodetect конфигурации.

<details>
<summary>Ответ</summary>
<br>

![Снимок экрана 2023-08-16 в 06 41 03](https://github.com/tomaevmax/devops-netology/assets/32243921/e83d7d56-8cf4-43f6-be7a-e4a116f3c28b)

</details>  

   
3. Сохраните необходимые шаги, запустите первую сборку master.

<details>
<summary>Ответ</summary>
<br>

![Снимок экрана 2023-08-16 в 06 42 55](https://github.com/tomaevmax/devops-netology/assets/32243921/2c066c0e-fd44-4e4d-ac51-3176a174949c)

</details>  

4. Поменяйте условия сборки: если сборка по ветке master, то должен происходит mvn clean deploy, иначе mvn clean test.

<details>
<summary>Ответ</summary>
<br>

![Снимок экрана 2023-08-16 в 06 48 41](https://github.com/tomaevmax/devops-netology/assets/32243921/da652775-fc05-41d1-832b-c6fcb5ea9f13)

</details>  

8. Для deploy будет необходимо загрузить settings.xml в набор конфигураций maven у teamcity, предварительно записав туда креды для подключения к nexus.   
9. В pom.xml необходимо поменять ссылки на репозиторий и nexus.   
10. Запустите сборку по master, убедитесь, что всё прошло успешно и артефакт появился в nexus.   
11. Мигрируйте build configuration в репозиторий.   
12. Создайте отдельную ветку feature/add_reply в репозитории.   
13. Напишите новый метод для класса Welcomer: метод должен возвращать произвольную реплику, содержащую слово hunter.   
14. Дополните тест для нового метода на поиск слова hunter в новой реплике.   
15. Сделайте push всех изменений в новую ветку репозитория.   
16. Убедитесь, что сборка самостоятельно запустилась, тесты прошли успешно.   
17. Внесите изменения из произвольной ветки feature/add_reply в master через Merge.   
18. Убедитесь, что нет собранного артефакта в сборке по ветке master.   
19. Настройте конфигурацию так, чтобы она собирала .jar в артефакты сборки.   
20. Проведите повторную сборку мастера, убедитесь, что сбора прошла успешно и артефакты собраны.   
21. Проверьте, что конфигурация в репозитории содержит все настройки конфигурации из teamcity.  
22. В ответе пришлите ссылку на репозиторий.   

<details>
<summary>Ответ</summary>
<br>

[repositary](https://github.com/tomaevmax/example-playbook)   
</details>  
