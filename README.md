# Домашнее задание к занятию 12 «GitLab»

## Основная часть   

1. DevOps   

В репозитории содержится код проекта на Python. Проект — RESTful API сервис. Ваша задача — автоматизировать сборку образа с выполнением python-скрипта:   

Образ собирается на основе centos:7.   
Python версии не ниже 3.7.   
Установлены зависимости: flask flask-jsonpify flask-restful.   
Создана директория /python_api.   
Скрипт из репозитория размещён в /python_api.   
Точка вызова: запуск скрипта.   
При комите в любую ветку должен собираться docker image с форматом имени hello:gitlab-$CI_COMMIT_SHORT_SHA . Образ должен быть выложен в Gitlab registry или yandex registry.   
8.* (задание необязательное к выполению) При комите в ветку master после сборки должен подняться pod в kubernetes. Примерный pipeline для push в kubernetes по ссылке. Если вы еще не знакомы с k8s - автоматизируйте сборку и деплой приложения в docker на виртуальной машине.     

<details>
<summary>Ответ</summary>
<br>

![Снимок экрана 2023-08-20 в 07 34 21](https://github.com/tomaevmax/devops-netology/assets/32243921/61a1162b-b6e2-4fef-99b6-ba25debaf480)   

![Снимок экрана 2023-08-20 в 07 35 03](https://github.com/tomaevmax/devops-netology/assets/32243921/eaf81453-c8a8-4c06-9393-1685495c8e8c)


</details>  

2. Product Owner   

Вашему проекту нужна бизнесовая доработка: нужно поменять JSON ответа на вызов метода GET /rest/api/get_info, необходимо создать Issue в котором указать:   

Какой метод необходимо исправить.
Текст с { "message": "Already started" } на { "message": "Running"}.
Issue поставить label: feature.   

<details>
<summary>Ответ</summary>
<br>

![Снимок экрана 2023-08-20 в 07 47 02](https://github.com/tomaevmax/devops-netology/assets/32243921/0a4eb798-0c65-4ae7-af0a-ed6a44273ba8)

</details>  

3. Developer   

Пришёл новый Issue на доработку, вам нужно:   

Создать отдельную ветку, связанную с этим Issue.   
Внести изменения по тексту из задания.   
Подготовить Merge Request, влить необходимые изменения в master, проверить, что сборка прошла успешно.    

<details>
<summary>Ответ</summary>
<br>

![Снимок экрана 2023-08-20 в 07 43 38](https://github.com/tomaevmax/devops-netology/assets/32243921/3cf43554-3e7d-4ac2-9818-5f538c56b3a8)   

![Снимок экрана 2023-08-20 в 07 51 37](https://github.com/tomaevmax/devops-netology/assets/32243921/40e4768e-dac2-4c1c-9809-995088c3fb6e)

````   
Running with gitlab-runner 16.1.0 (b72e108d)
  on gitlab-runner1-6b6fb86685-hm6fr 2HyjrDMp, system ID: r_AsOsoR2s5Ypt
Preparing the "kubernetes" executor
00:00
Using Kubernetes namespace: default
Using Kubernetes executor with image cr.yandex/yc/metadata-token-docker-helper:0.2 ...
Using attach strategy to execute scripts...
Preparing environment
00:04
Waiting for pod default/runner-2hyjrdmp-project-1-concurrent-07nqzv to be running, status is Pending
Running on runner-2hyjrdmp-project-1-concurrent-07nqzv via gitlab-runner1-6b6fb86685-hm6fr...
Getting source from Git repository
00:01
Fetching changes with git depth set to 20...
Initialized empty Git repository in /builds/netology/example-netology/.git/
Created fresh repository.
Checking out a126e601 as detached HEAD (ref is main)...
Skipping Git submodules setup
Executing "step_script" stage of the job script
01:02
$ echo "Deploying application..."
Deploying application...
$ docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY
WARNING! Using --password via the CLI is insecure. Use --password-stdin.
WARNING! Your password will be stored unencrypted in /opt/ycr/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store
Login Succeeded
$ docker build . -t $CI_REGISTRY/netology/example-netology/hello:gitlab-$CI_COMMIT_SHORT_SHA
Step 1/7 : FROM centos:7
7: Pulling from library/centos
2d473b07cdd5: Pulling fs layer
2d473b07cdd5: Verifying Checksum
2d473b07cdd5: Download complete
2d473b07cdd5: Pull complete
Digest: sha256:be65f488b7764ad3638f236b7b515b3678369a5124c47b8d32916d6487418ea4
Status: Downloaded newer image for centos:7
 ---> eeb6ee3f44bd
Step 2/7 : RUN yum install python3 python3-pip -y
 ---> Running in bf58c325a4fa
Loaded plugins: fastestmirror, ovl
Determining fastest mirrors
 * base: mirror.sale-dedic.com
 * extras: mirror.surf
 * updates: mirror.sale-dedic.com
Resolving Dependencies
--> Running transaction check
---> Package python3.x86_64 0:3.6.8-19.el7_9 will be installed
--> Processing Dependency: python3-libs(x86-64) = 3.6.8-19.el7_9 for package: python3-3.6.8-19.el7_9.x86_64
--> Processing Dependency: python3-setuptools for package: python3-3.6.8-19.el7_9.x86_64
--> Processing Dependency: libpython3.6m.so.1.0()(64bit) for package: python3-3.6.8-19.el7_9.x86_64
---> Package python3-pip.noarch 0:9.0.3-8.el7 will be installed
--> Running transaction check
---> Package python3-libs.x86_64 0:3.6.8-19.el7_9 will be installed
--> Processing Dependency: libtirpc.so.1()(64bit) for package: python3-libs-3.6.8-19.el7_9.x86_64
---> Package python3-setuptools.noarch 0:39.2.0-10.el7 will be installed
--> Running transaction check
---> Package libtirpc.x86_64 0:0.2.4-0.16.el7 will be installed
--> Finished Dependency Resolution
Dependencies Resolved
================================================================================
 Package                  Arch         Version              Repository     Size
================================================================================
Installing:
 python3                  x86_64       3.6.8-19.el7_9       updates        70 k
 python3-pip              noarch       9.0.3-8.el7          base          1.6 M
Installing for dependencies:
 libtirpc                 x86_64       0.2.4-0.16.el7       base           89 k
 python3-libs             x86_64       3.6.8-19.el7_9       updates       6.9 M
 python3-setuptools       noarch       39.2.0-10.el7        base          629 k
Transaction Summary
================================================================================
Install  2 Packages (+3 Dependent packages)
Total download size: 9.3 M
Installed size: 48 M
Downloading packages:
warning: /var/cache/yum/x86_64/7/updates/packages/python3-3.6.8-19.el7_9.x86_64.rpm: Header V4 RSA/SHA256 Signature, key ID f4a80eb5: NOKEY
Public key for python3-3.6.8-19.el7_9.x86_64.rpm is not installed
Public key for libtirpc-0.2.4-0.16.el7.x86_64.rpm is not installed
--------------------------------------------------------------------------------
Total                                               32 MB/s | 9.3 MB  00:00     
Retrieving key from file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
Importing GPG key 0xF4A80EB5:
 Userid     : "CentOS-7 Key (CentOS 7 Official Signing Key) <security@centos.org>"
 Fingerprint: 6341 ab27 53d7 8a78 a7c2 7bb1 24c6 a8a7 f4a8 0eb5
 Package    : centos-release-7-9.2009.0.el7.centos.x86_64 (@CentOS)
 From       : /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Installing : libtirpc-0.2.4-0.16.el7.x86_64                               1/5
 
  Installing : python3-setuptools-39.2.0-10.el7.noarch                      2/5 
  Installing : python3-pip-9.0.3-8.el7.noarch                               3/5 
  Installing : python3-3.6.8-19.el7_9.x86_64                                4/5
 
  Installing : python3-libs-3.6.8-19.el7_9.x86_64                           5/5 
  Verifying  : libtirpc-0.2.4-0.16.el7.x86_64                               1/5 
  Verifying  : python3-libs-3.6.8-19.el7_9.x86_64                           2/5 
  Verifying  : python3-3.6.8-19.el7_9.x86_64                                3/5 
  Verifying  : python3-setuptools-39.2.0-10.el7.noarch                      4/5 
  Verifying  : python3-pip-9.0.3-8.el7.noarch                               5/5
 
Installed:
  python3.x86_64 0:3.6.8-19.el7_9        python3-pip.noarch 0:9.0.3-8.el7       
Dependency Installed:
  libtirpc.x86_64 0:0.2.4-0.16.el7                                              
  python3-libs.x86_64 0:3.6.8-19.el7_9                                          
  python3-setuptools.noarch 0:39.2.0-10.el7                                     
Complete!
Removing intermediate container bf58c325a4fa
 ---> 795f3fa5a727
Step 3/7 : COPY requirements.txt requirements.txt
 ---> 1fa9e213b22c
Step 4/7 : RUN pip3 install -r requirements.txt
 ---> Running in 6c44d818e5ce
WARNING: Running pip install with root privileges is generally not a good idea. Try `pip3 install --user` instead.
Collecting flask (from -r requirements.txt (line 1))
  Downloading https://files.pythonhosted.org/packages/cd/77/59df23681f4fd19b7cbbb5e92484d46ad587554f5d490f33ef907e456132/Flask-2.0.3-py3-none-any.whl (95kB)
Collecting flask_restful (from -r requirements.txt (line 2))
  Downloading https://files.pythonhosted.org/packages/d7/7b/f0b45f0df7d2978e5ae51804bb5939b7897b2ace24306009da0cc34d8d1f/Flask_RESTful-0.3.10-py2.py3-none-any.whl
Collecting flask_jsonpify (from -r requirements.txt (line 3))
  Downloading https://files.pythonhosted.org/packages/60/0f/c389dea3988bffbe32c1a667989914b1cc0bce31b338c8da844d5e42b503/Flask-Jsonpify-1.5.0.tar.gz
Collecting Werkzeug>=2.0 (from flask->-r requirements.txt (line 1))
  Downloading https://files.pythonhosted.org/packages/f4/f3/22afbdb20cc4654b10c98043414a14057cd27fdba9d4ae61cea596000ba2/Werkzeug-2.0.3-py3-none-any.whl (289kB)
Collecting Jinja2>=3.0 (from flask->-r requirements.txt (line 1))
  Downloading https://files.pythonhosted.org/packages/20/9a/e5d9ec41927401e41aea8af6d16e78b5e612bca4699d417f646a9610a076/Jinja2-3.0.3-py3-none-any.whl (133kB)
Collecting itsdangerous>=2.0 (from flask->-r requirements.txt (line 1))
  Downloading https://files.pythonhosted.org/packages/9c/96/26f935afba9cd6140216da5add223a0c465b99d0f112b68a4ca426441019/itsdangerous-2.0.1-py3-none-any.whl
Collecting click>=7.1.2 (from flask->-r requirements.txt (line 1))
  Downloading https://files.pythonhosted.org/packages/4a/a8/0b2ced25639fb20cc1c9784de90a8c25f9504a7f18cd8b5397bd61696d7d/click-8.0.4-py3-none-any.whl (97kB)
Collecting six>=1.3.0 (from flask_restful->-r requirements.txt (line 2))
  Downloading https://files.pythonhosted.org/packages/d9/5a/e7c31adbe875f2abbb91bd84cf2dc52d792b5a01506781dbcf25c91daf11/six-1.16.0-py2.py3-none-any.whl
Collecting pytz (from flask_restful->-r requirements.txt (line 2))
  Downloading https://files.pythonhosted.org/packages/7f/99/ad6bd37e748257dd70d6f85d916cafe79c0b0f5e2e95b11f7fbc82bf3110/pytz-2023.3-py2.py3-none-any.whl (502kB)
Collecting aniso8601>=0.82 (from flask_restful->-r requirements.txt (line 2))
  Downloading https://files.pythonhosted.org/packages/e3/04/e97c12dc034791d7b504860acfcdd2963fa21ae61eaca1c9d31245f812c3/aniso8601-9.0.1-py2.py3-none-any.whl (52kB)
Collecting dataclasses; python_version < "3.7" (from Werkzeug>=2.0->flask->-r requirements.txt (line 1))
  Downloading https://files.pythonhosted.org/packages/fe/ca/75fac5856ab5cfa51bbbcefa250182e50441074fdc3f803f6e76451fab43/dataclasses-0.8-py3-none-any.whl
Collecting MarkupSafe>=2.0 (from Jinja2>=3.0->flask->-r requirements.txt (line 1))
  Downloading https://files.pythonhosted.org/packages/fc/d6/57f9a97e56447a1e340f8574836d3b636e2c14de304943836bd645fa9c7e/MarkupSafe-2.0.1-cp36-cp36m-manylinux1_x86_64.whl
Collecting importlib-metadata; python_version < "3.8" (from click>=7.1.2->flask->-r requirements.txt (line 1))
  Downloading https://files.pythonhosted.org/packages/a0/a1/b153a0a4caf7a7e3f15c2cd56c7702e2cf3d89b1b359d1f1c5e59d68f4ce/importlib_metadata-4.8.3-py3-none-any.whl
Collecting typing-extensions>=3.6.4; python_version < "3.8" (from importlib-metadata; python_version < "3.8"->click>=7.1.2->flask->-r requirements.txt (line 1))
  Downloading https://files.pythonhosted.org/packages/45/6b/44f7f8f1e110027cf88956b59f2fad776cca7e1704396d043f89effd3a0e/typing_extensions-4.1.1-py3-none-any.whl
Collecting zipp>=0.5 (from importlib-metadata; python_version < "3.8"->click>=7.1.2->flask->-r requirements.txt (line 1))
  Downloading https://files.pythonhosted.org/packages/bd/df/d4a4974a3e3957fd1c1fa3082366d7fff6e428ddb55f074bf64876f8e8ad/zipp-3.6.0-py3-none-any.whl
Installing collected packages: dataclasses, Werkzeug, MarkupSafe, Jinja2, itsdangerous, typing-extensions, zipp, importlib-metadata, click, flask, six, pytz, aniso8601, flask-restful, flask-jsonpify
  Running setup.py install for flask-jsonpify: started
    Running setup.py install for flask-jsonpify: finished with status 'done'
Successfully installed Jinja2-3.0.3 MarkupSafe-2.0.1 Werkzeug-2.0.3 aniso8601-9.0.1 click-8.0.4 dataclasses-0.8 flask-2.0.3 flask-jsonpify-1.5.0 flask-restful-0.3.10 importlib-metadata-4.8.3 itsdangerous-2.0.1 pytz-2023.3 six-1.16.0 typing-extensions-4.1.1 zipp-3.6.0
Removing intermediate container 6c44d818e5ce
 ---> 6213db7fde12
Step 5/7 : WORKDIR /python_api
 ---> Running in 18935033a19f
Removing intermediate container 18935033a19f
 ---> 6755d4048033
Step 6/7 : COPY python-api.py python-api.py
 ---> c7542ab4cdb0
Step 7/7 : CMD ["python3", "python-api.py"]
 ---> Running in 03b17e8d0824
Removing intermediate container 03b17e8d0824
 ---> 608a2d1810bf
Successfully built 608a2d1810bf
Successfully tagged tomaevmax.gitlab.yandexcloud.net:5050/netology/example-netology/hello:gitlab-a126e601
$ docker push $CI_REGISTRY/netology/example-netology/hello:gitlab-$CI_COMMIT_SHORT_SHA
The push refers to repository [tomaevmax.gitlab.yandexcloud.net:5050/netology/example-netology/hello]
ac382836b3ff: Preparing
d6ac15c785dd: Preparing
7322e0482fc4: Preparing
ef36ec5b3da9: Preparing
9c636d7721cb: Preparing
174f56854903: Preparing
174f56854903: Waiting
d6ac15c785dd: Pushed
ef36ec5b3da9: Pushed
ac382836b3ff: Pushed
174f56854903: Layer already exists
7322e0482fc4: Pushed
9c636d7721cb: Pushed
gitlab-a126e601: digest: sha256:5dd29dabf6b516c6a8dc7f1c7074ac598bc22d06beb99e02b134b9cd44fb90d5 size: 1573
Cleaning up project directory and file based variables
00:00
Job succeeded
````   

</details>  

4. Tester   

Разработчики выполнили новый Issue, необходимо проверить валидность изменений:

Поднять докер-контейнер с образом python-api:latest и проверить возврат метода на корректность.
Закрыть Issue с комментарием об успешности прохождения, указав желаемый результат и фактически достигнутый.

<details>
<summary>Ответ</summary>
<br>

![Снимок экрана 2023-08-20 в 08 11 33](https://github.com/tomaevmax/devops-netology/assets/32243921/581ec944-13e5-4815-b698-51eb188bae21)


![Снимок экрана 2023-08-20 в 08 13 48](https://github.com/tomaevmax/devops-netology/assets/32243921/5a28fbec-51b5-4fc3-a4e7-05c3df88c169)

</details>  


Файлы:   
[gitlab-ci.yml](gitlab-ci.yml)   
[Dockerfile](Dockerfile)   
