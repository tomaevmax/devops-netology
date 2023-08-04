# Домашнее задание к занятию 9 «Процессы CI/CD»   

## Знакомоство с SonarQube   

1. Создайте новый проект, название произвольное.   
2. Скачайте пакет sonar-scanner, который вам предлагает скачать SonarQube.   
3. Сделайте так, чтобы binary был доступен через вызов в shell (или поменяйте переменную PATH, или любой другой, удобный вам способ).   
4. Проверьте sonar-scanner --version.   

<details>
<summary>Ответ</summary>
<br>

```   
➜  bin git:(main) ✗ sonar-scanner --version           
INFO: Scanner configuration file: /Users/maksimtomaev/Downloads/repa/sonar-scanner-5.0.0.2966-macosx/conf/sonar-scanner.properties
INFO: Project root configuration file: NONE
INFO: SonarScanner 5.0.0.2966
INFO: Java 17.0.7 Eclipse Adoptium (64-bit)
INFO: Mac OS X 13.4.1 x86_64
```   
</details>  

5. Запустите анализатор против кода из директории example с дополнительным ключом -Dsonar.coverage.exclusions=fail.py.   

<details>
<summary>Ответ</summary>
<br>

```   
➜  example git:(ansible-dz8) ✗ sonar-scanner \                   
  -Dsonar.projectKey=netology \
  -Dsonar.sources=. \
  -Dsonar.host.url=http://51.250.10.132:9000 \
  -Dsonar.login=7af1a240a114278695a6c26f20eee74b491f063d \
-Dsonar.coverage.exclusions=fail.py
INFO: Scanner configuration file: /Users/maksimtomaev/Downloads/repa/sonar-scanner-5.0.0.2966-macosx/conf/sonar-scanner.properties
INFO: Project root configuration file: NONE
INFO: SonarScanner 5.0.0.2966
INFO: Java 17.0.7 Eclipse Adoptium (64-bit)
INFO: Mac OS X 13.4.1 x86_64
INFO: User cache: /Users/maksimtomaev/.sonar/cache
INFO: Analyzing on SonarQube server 9.1.0
INFO: Default locale: "ru_RU", source code encoding: "UTF-8" (analysis is platform dependent)
INFO: Load global settings
INFO: Load global settings (done) | time=211ms
INFO: Server id: 9CFC3560-AYm5hNCKM9IJLEz2jvVa
INFO: User cache: /Users/maksimtomaev/.sonar/cache
INFO: Load/download plugins
INFO: Load plugins index
INFO: Load plugins index (done) | time=88ms
INFO: Load/download plugins (done) | time=19298ms
INFO: Process project properties
INFO: Process project properties (done) | time=14ms
INFO: Execute project builders
INFO: Execute project builders (done) | time=5ms
INFO: Project key: netology
INFO: Base dir: /Users/maksimtomaev/Downloads/repa/devops-netology/example
INFO: Working dir: /Users/maksimtomaev/Downloads/repa/devops-netology/example/.scannerwork
INFO: Load project settings for component key: 'netology'
INFO: Load project settings for component key: 'netology' (done) | time=85ms
INFO: Load quality profiles
INFO: Load quality profiles (done) | time=157ms
INFO: Load active rules
INFO: Load active rules (done) | time=3421ms
INFO: Indexing files...
INFO: Project configuration:
INFO:   Excluded sources for coverage: fail.py
INFO: 1 file indexed
INFO: 0 files ignored because of scm ignore settings
INFO: Quality profile for py: Sonar way
INFO: ------------- Run sensors on module netology
INFO: Load metrics repository
INFO: Load metrics repository (done) | time=114ms
INFO: Sensor Python Sensor [python]
WARN: Your code is analyzed as compatible with python 2 and 3 by default. This will prevent the detection of issues specific to python 2 or python 3. You can get a more precise analysis by setting a python version in your configuration via the parameter "sonar.python.version"
INFO: Starting global symbols computation
INFO: 1 source file to be analyzed
INFO: Load project repositories
INFO: Load project repositories (done) | time=61ms
INFO: 1/1 source file has been analyzed
INFO: Starting rules execution
INFO: 1 source file to be analyzed
INFO: 1/1 source file has been analyzed
INFO: Sensor Python Sensor [python] (done) | time=690ms
INFO: Sensor Cobertura Sensor for Python coverage [python]
INFO: Sensor Cobertura Sensor for Python coverage [python] (done) | time=5ms
INFO: Sensor PythonXUnitSensor [python]
INFO: Sensor PythonXUnitSensor [python] (done) | time=1ms
INFO: Sensor CSS Rules [cssfamily]
INFO: No CSS, PHP, HTML or VueJS files are found in the project. CSS analysis is skipped.
INFO: Sensor CSS Rules [cssfamily] (done) | time=1ms
INFO: Sensor JaCoCo XML Report Importer [jacoco]
INFO: 'sonar.coverage.jacoco.xmlReportPaths' is not defined. Using default locations: target/site/jacoco/jacoco.xml,target/site/jacoco-it/jacoco.xml,build/reports/jacoco/test/jacocoTestReport.xml
INFO: No report imported, no coverage information will be imported by JaCoCo XML Report Importer
INFO: Sensor JaCoCo XML Report Importer [jacoco] (done) | time=3ms
INFO: Sensor C# Project Type Information [csharp]
INFO: Sensor C# Project Type Information [csharp] (done) | time=1ms
INFO: Sensor C# Analysis Log [csharp]
INFO: Sensor C# Analysis Log [csharp] (done) | time=10ms
INFO: Sensor C# Properties [csharp]
INFO: Sensor C# Properties [csharp] (done) | time=0ms
INFO: Sensor JavaXmlSensor [java]
INFO: Sensor JavaXmlSensor [java] (done) | time=1ms
INFO: Sensor HTML [web]
INFO: Sensor HTML [web] (done) | time=2ms
INFO: Sensor VB.NET Project Type Information [vbnet]
INFO: Sensor VB.NET Project Type Information [vbnet] (done) | time=1ms
INFO: Sensor VB.NET Analysis Log [vbnet]
INFO: Sensor VB.NET Analysis Log [vbnet] (done) | time=8ms
INFO: Sensor VB.NET Properties [vbnet]
INFO: Sensor VB.NET Properties [vbnet] (done) | time=0ms
INFO: ------------- Run sensors on project
INFO: Sensor Zero Coverage Sensor
INFO: Sensor Zero Coverage Sensor (done) | time=0ms
INFO: SCM Publisher SCM provider for this project is: git
INFO: SCM Publisher 1 source file to be analyzed
INFO: SCM Publisher 0/1 source files have been analyzed (done) | time=93ms
WARN: Missing blame information for the following files:
WARN:   * fail.py
WARN: This may lead to missing/broken features in SonarQube
INFO: CPD Executor Calculating CPD for 1 file
INFO: CPD Executor CPD calculation finished (done) | time=7ms
INFO: Analysis report generated in 93ms, dir size=103,2 kB
INFO: Analysis report compressed in 22ms, zip size=14,3 kB
INFO: Analysis report uploaded in 100ms
INFO: ANALYSIS SUCCESSFUL, you can browse http://51.250.10.132:9000/dashboard?id=netology
INFO: Note that you will be able to access the updated dashboard once the server has processed the submitted analysis report
INFO: More about the report processing at http://51.250.10.132:9000/api/ce/task?id=AYm5mqpaM9IJLEz2j0ah
INFO: Analysis total time: 7.162 s
INFO: ------------------------------------------------------------------------
INFO: EXECUTION SUCCESS
INFO: ------------------------------------------------------------------------
INFO: Total time: 35.836s
INFO: Final Memory: 8M/40M
INFO: ------------------------------------------------------------------------

```   
</details>  

6. Посмотрите результат в интерфейсе.   

<details>
<summary>Ответ</summary>
<br>

![Снимок экрана 2023-08-03 в 07 20 05](https://github.com/tomaevmax/devops-netology/assets/32243921/1f04d585-5914-4026-95ea-0f1789cac55c)

</details>   

7. Исправьте ошибки, которые он выявил, включая warnings.   
8. Запустите анализатор повторно — проверьте, что QG пройдены успешно.   
9. Сделайте скриншот успешного прохождения анализа, приложите к решению ДЗ.   

<details>
<summary>Ответ</summary>
<br>

![Снимок экрана 2023-08-03 в 07 27 04](https://github.com/tomaevmax/devops-netology/assets/32243921/b008087d-367c-4775-90c1-89f1ffc21386)

</details>   

## Знакомство с Nexus   

1. В репозиторий maven-public загрузите артефакт с GAV-параметрами:   
 groupId: netology;   
 artifactId: java;   
 version: 8_282;  
 classifier: distrib;   
 type: tar.gz.   
2. В него же загрузите такой же артефакт, но с version: 8_102.   
3. Проверьте, что все файлы загрузились успешно.   
4. В ответе пришлите файл maven-metadata.xml для этого артефекта.   

<details>
<summary>Ответ</summary>
<br>

[maven-metadate](maven-metadata.xml)   
</details>  

##  Знакомство с Maven

1. Поменяйте в pom.xml блок с зависимостями под ваш артефакт из первого пункта задания для Nexus (java с версией 8_282).
2. Запустите команду mvn package в директории с pom.xml, ожидайте успешного окончания.

<details>
<summary>Ответ</summary>
<br>

````
[WARNING] JAR will be empty - no content was marked for inclusion!
[INFO] Building jar: /Users/maksimtomaev/Downloads/repa/devops-netology/mvn/target/simple-app-1.0-SNAPSHOT.jar
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  11.079 s
[INFO] Finished at: 2023-08-04T06:54:55+03:00
[INFO] ------------------------------------------------------------------------

````   

</details>   

3. Проверьте директорию ~/.m2/repository/, найдите ваш артефакт.

<details>
<summary>Ответ</summary>
<br>

````
➜  mvn git:(ansible-dz8) ✗ ls ~/.m2/repository/netology/java/8_282 
_remote.repositories        java-8_282-distrib.jar      java-8_282-distrib.jar.sha1 java-8_282.pom.lastUpdated

````   

</details>  

4. В ответе пришлите исправленный файл pom.xml.   

<details>
<summary>Ответ</summary>
<br>

[pom.xml](mvn/pom.xml)   
</details>  