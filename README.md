# Домашнее задание к занятию 5 «Тестирование roles»

## Задача
1. Запустите  molecule test -s centos_7 внутри корневой директории clickhouse-role, посмотрите на вывод команды. Данная команда может отработать с ошибками, это нормально. Наша цель - посмотреть как другие в реальном мире используют молекулу.      

## Ответ   
````   
➜  clickhouse git:(ansible-dz5) ✗ molecule test -s centos_7
WARNING  Driver docker does not provide a schema.
INFO     centos_7 scenario test matrix: dependency, cleanup, destroy, syntax, create, prepare, converge, idempotence, side_effect, verify, cleanup, destroy
INFO     Performing prerun with role_name_check=0...
INFO     Set ANSIBLE_LIBRARY=/Users/maksimtomaev/.cache/ansible-compat/7e099f/modules:/Users/maksimtomaev/.ansible/plugins/modules:/usr/share/ansible/plugins/modules
INFO     Set ANSIBLE_COLLECTIONS_PATH=/Users/maksimtomaev/.cache/ansible-compat/7e099f/collections:/Users/maksimtomaev/.ansible/collections:/usr/share/ansible/collections
INFO     Set ANSIBLE_ROLES_PATH=/Users/maksimtomaev/.cache/ansible-compat/7e099f/roles:/Users/maksimtomaev/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles
INFO     Using /Users/maksimtomaev/.cache/ansible-compat/7e099f/roles/alexeysetevoi.clickhouse symlink to current repository in order to enable Ansible to find the role using its expected full name.
INFO     Running centos_7 > dependency
WARNING  Skipping, missing the requirements file.
WARNING  Skipping, missing the requirements file.
INFO     Running centos_7 > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running centos_7 > destroy
INFO     Sanity checks: 'docker'

PLAY [Destroy] *****************************************************************

TASK [Set async_dir for HOME env] **********************************************
ok: [localhost]

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item=centos_7)

TASK [Wait for instance(s) deletion to complete] *******************************
FAILED - RETRYING: [localhost]: Wait for instance(s) deletion to complete (300 retries left).
ok: [localhost] => (item=centos_7)

TASK [Delete docker networks(s)] ***********************************************
skipping: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=3    changed=1    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Running centos_7 > syntax

playbook: /Users/maksimtomaev/Downloads/repa/devops-netology/playbook/roles/clickhouse/molecule/centos_7/converge.yml
INFO     Running centos_7 > create

PLAY [Create] ******************************************************************

TASK [Set async_dir for HOME env] **********************************************
ok: [localhost]

TASK [Log into a Docker registry] **********************************************
skipping: [localhost] => (item=None) 
skipping: [localhost]

TASK [Check presence of custom Dockerfiles] ************************************
ok: [localhost] => (item={'capabilities': ['SYS_ADMIN'], 'command': '/usr/sbin/init', 'dockerfile': '../resources/Dockerfile.j2', 'env': {'ANSIBLE_USER': 'ansible', 'DEPLOY_GROUP': 'deployer', 'SUDO_GROUP': 'wheel', 'container': 'docker'}, 'image': 'centos:7', 'name': 'centos_7', 'privileged': True, 'tmpfs': ['/run', '/tmp'], 'volumes': ['/sys/fs/cgroup:/sys/fs/cgroup']})

TASK [Create Dockerfiles from image names] *************************************
changed: [localhost] => (item={'capabilities': ['SYS_ADMIN'], 'command': '/usr/sbin/init', 'dockerfile': '../resources/Dockerfile.j2', 'env': {'ANSIBLE_USER': 'ansible', 'DEPLOY_GROUP': 'deployer', 'SUDO_GROUP': 'wheel', 'container': 'docker'}, 'image': 'centos:7', 'name': 'centos_7', 'privileged': True, 'tmpfs': ['/run', '/tmp'], 'volumes': ['/sys/fs/cgroup:/sys/fs/cgroup']})

TASK [Synchronization the context] *********************************************
changed: [localhost] => (item={'capabilities': ['SYS_ADMIN'], 'command': '/usr/sbin/init', 'dockerfile': '../resources/Dockerfile.j2', 'env': {'ANSIBLE_USER': 'ansible', 'DEPLOY_GROUP': 'deployer', 'SUDO_GROUP': 'wheel', 'container': 'docker'}, 'image': 'centos:7', 'name': 'centos_7', 'privileged': True, 'tmpfs': ['/run', '/tmp'], 'volumes': ['/sys/fs/cgroup:/sys/fs/cgroup']})

TASK [Discover local Docker images] ********************************************
ok: [localhost] => (item=None)
ok: [localhost]

TASK [Build an Ansible compatible image (new)] *********************************
ok: [localhost] => (item=molecule_local/centos:7)

TASK [Create docker network(s)] ************************************************
skipping: [localhost]

TASK [Determine the CMD directives] ********************************************
ok: [localhost] => (item=None)
ok: [localhost]

TASK [Create molecule instance(s)] *********************************************
changed: [localhost] => (item=centos_7)

TASK [Wait for instance(s) creation to complete] *******************************
FAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (300 retries left).
changed: [localhost] => (item=None)
changed: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=9    changed=4    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0

INFO     Running centos_7 > prepare
WARNING  Skipping, prepare playbook not configured.
INFO     Running centos_7 > converge

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [centos_7]

TASK [Include ansible-clickhouse] **********************************************

TASK [clickhouse : Include OS Family Specific Variables] ***********************
ok: [centos_7]

TASK [clickhouse : include_tasks] **********************************************
included: /Users/maksimtomaev/Downloads/repa/devops-netology/playbook/roles/clickhouse/tasks/precheck.yml for centos_7

TASK [clickhouse : Requirements check | Checking sse4_2 support] ***************
fatal: [centos_7]: FAILED! => {"changed": false, "cmd": ["grep", "-q", "sse4_2", "/proc/cpuinfo"], "delta": "0:00:00.235543", "end": "2023-07-16 04:23:52.924712", "msg": "non-zero return code", "rc": 1, "start": "2023-07-16 04:23:52.689169", "stderr": "", "stderr_lines": [], "stdout": "", "stdout_lines": []}

PLAY RECAP *********************************************************************
centos_7                   : ok=3    changed=0    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0

CRITICAL Ansible return code was 2, command was: ['ansible-playbook', '-D', '--inventory', '/Users/maksimtomaev/.cache/molecule/clickhouse/centos_7/inventory', '--skip-tags', 'molecule-notest,notest', '/Users/maksimtomaev/Downloads/repa/devops-netology/playbook/roles/clickhouse/molecule/centos_7/converge.yml']
WARNING  An error occurred during the test sequence action: 'converge'. Cleaning up.
INFO     Running centos_7 > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running centos_7 > destroy

PLAY [Destroy] *****************************************************************

TASK [Set async_dir for HOME env] **********************************************
ok: [localhost]

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item=centos_7)

TASK [Wait for instance(s) deletion to complete] *******************************
FAILED - RETRYING: [localhost]: Wait for instance(s) deletion to complete (300 retries left).
changed: [localhost] => (item=centos_7)

TASK [Delete docker networks(s)] ***********************************************
skipping: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=3    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Pruning extra files from scenario ephemeral directory
````   

## Задача   
2. Перейдите в каталог с ролью vector-role и создайте сценарий тестирования по умолчанию при помощи molecule init scenario --driver-name docker.   

## Ответ    
````   
 vector-role git:(master) ✗ molecule init scenario --driver-name docker
INFO     Initializing new scenario default...
INFO     Initialized scenario in /Users/maksimtomaev/Downloads/repa/devops-netology/vectore-role/vector-role/molecule/default successfully.
 
````  

## Задача   
3. Добавьте несколько разных дистрибутивов (centos:8, ubuntu:latest) для инстансов и протестируйте роль, исправьте найденные ошибки, если они есть.
4. Добавьте несколько assert в verify.yml-файл для проверки работоспособности vector-role (проверка, что конфиг валидный, проверка успешности запуска и др.).    

## Ответ   
[instance](https://github.com/tomaevmax/vector-role/blob/1.0.2/molecule/default/molecule.yml)   
[verify](https://github.com/tomaevmax/vector-role/blob/1.0.2/molecule/default/verify.yml)

## Задача   
5. Запустите тестирование роли повторно и проверьте, что оно прошло успешно.

## Ответ    
```` 
[netology@dz5 vector-role]$ molecule test -s default --destroy never
INFO     default scenario test matrix: dependency, lint, cleanup, destroy, syntax, create, prepare, converge, idempotence, side_effect, verify, cleanup, destroy
INFO     Performing prerun...
INFO     Set ANSIBLE_LIBRARY=/home/netology/.cache/ansible-compat/f5bcd7/modules:/home/netology/.ansible/plugins/modules:/usr/share/ansible/plugins/modules
INFO     Set ANSIBLE_COLLECTIONS_PATH=/home/netology/.cache/ansible-compat/f5bcd7/collections:/home/netology/.ansible/collections:/usr/share/ansible/collections
INFO     Set ANSIBLE_ROLES_PATH=/home/netology/.cache/ansible-compat/f5bcd7/roles:/home/netology/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles
INFO     Running default > dependency
WARNING  Skipping, missing the requirements file.
WARNING  Skipping, missing the requirements file.
INFO     Running default > lint
INFO     Lint is disabled.
INFO     Running default > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running default > destroy
WARNING  Skipping, '--destroy=never' requested.
INFO     Running default > syntax
INFO     Sanity checks: 'docker'

playbook: /opt/vector-role/molecule/default/converge.yml
INFO     Running default > create
WARNING  Skipping, instances already created.
INFO     Running default > prepare
WARNING  Skipping, prepare playbook not configured.
INFO     Running default > converge

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [ubuntu]
ok: [centos]

TASK [Include vector-role] *****************************************************

TASK [vector-role : include_tasks] *********************************************
skipping: [centos]
included: /opt/vector-role/tasks/deb.yml for ubuntu

TASK [vector-role : Get Vector distrib] ****************************************
ok: [ubuntu]

TASK [vector-role : Install Vector packages] ***********************************
ok: [ubuntu]

TASK [vector-role : include_tasks] *********************************************
skipping: [ubuntu]
included: /opt/vector-role/tasks/rpm.yml for centos

TASK [vector-role : Get vector distrib] ****************************************
ok: [centos]

TASK [vector-role : Install vector packages] ***********************************
ok: [centos]

TASK [vector-role : Flush handlers] ********************************************

PLAY RECAP *********************************************************************
centos                     : ok=4    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
ubuntu                     : ok=4    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Running default > idempotence

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [ubuntu]
ok: [centos]

TASK [Include vector-role] *****************************************************

TASK [vector-role : include_tasks] *********************************************
skipping: [centos]
included: /opt/vector-role/tasks/deb.yml for ubuntu

TASK [vector-role : Get Vector distrib] ****************************************
ok: [ubuntu]

TASK [vector-role : Install Vector packages] ***********************************
ok: [ubuntu]

TASK [vector-role : include_tasks] *********************************************
skipping: [ubuntu]
included: /opt/vector-role/tasks/rpm.yml for centos

TASK [vector-role : Get vector distrib] ****************************************
ok: [centos]

TASK [vector-role : Install vector packages] ***********************************
ok: [centos]

TASK [vector-role : Flush handlers] ********************************************

PLAY RECAP *********************************************************************
centos                     : ok=4    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
ubuntu                     : ok=4    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Idempotence completed successfully.
INFO     Running default > side_effect
WARNING  Skipping, side effect playbook not configured.
INFO     Running default > verify
INFO     Running Ansible Verifier

PLAY [Verify] ******************************************************************

TASK [Validation Vector configuration] *****************************************
ok: [centos]
ok: [ubuntu]

TASK [Assert Vector validate config] *******************************************
ok: [centos] => {
    "changed": false,
    "msg": "All assertions passed"
}
ok: [ubuntu] => {
    "changed": false,
    "msg": "All assertions passed"
}

PLAY RECAP *********************************************************************
centos                     : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Verifier completed successfully.
INFO     Running default > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running default > destroy
WARNING  Skipping, '--destroy=never' requested.

````   
## Задача   
6. Добавьте новый тег на коммит с рабочим сценарием в соответствии с семантическим версионированием.   

## Ответ   
[tag 1.0.2](https://github.com/tomaevmax/vector-role/releases/tag/1.0.2)   

## Tox
## Задача   
1. Добавьте в директорию с vector-role файлы из директории.   
2. Запустите docker run --privileged=True -v <path_to_repo>:/opt/vector-role -w /opt/vector-role -it aragast/netology:latest /bin/bash, где path_to_repo — путь до корня репозитория с vector-role на вашей файловой системе.   
3. Внутри контейнера выполните команду tox, посмотрите на вывод.   

## Ответ   
````
[netology@dz5 vector-role]$ docker run --privileged=True -v /opt/vector-role:/opt/vector-role -w /opt/vector-role -it aragast/netology:latest /bin/bash
[root@d411305d0da3 vector-role]# tox
py37-ansible210 create: /opt/vector-role/.tox/py37-ansible210
py37-ansible210 installdeps: -rtox-requirements.txt, ansible<3.0
py37-ansible210 installed: ansible==2.10.7,ansible-base==2.10.17,ansible-compat==1.0.0,ansible-lint==5.1.3,arrow==1.2.3,bcrypt==4.0.1,binaryornot==0.4.4,bracex==2.3.post1,cached-property==1.5.2,Cerberus==1.3.2,certifi==2023.5.7,cffi==1.15.1,chardet==5.1.0,charset-normalizer==3.2.0,click==8.1.5,click-help-colors==0.9.1,cookiecutter==2.2.3,cryptography==41.0.2,distro==1.8.0,enrich==1.2.7,idna==3.4,importlib-metadata==6.7.0,Jinja2==3.1.2,jmespath==1.0.1,lxml==4.9.3,markdown-it-py==2.2.0,MarkupSafe==2.1.3,mdurl==0.1.2,molecule==3.5.2,molecule-podman==1.1.0,packaging==23.1,paramiko==2.12.0,pathspec==0.11.1,pluggy==1.2.0,pycparser==2.21,Pygments==2.15.1,PyNaCl==1.5.0,python-dateutil==2.8.2,python-slugify==8.0.1,PyYAML==5.4.1,requests==2.31.0,rich==13.4.2,ruamel.yaml==0.17.32,ruamel.yaml.clib==0.2.7,selinux==0.2.1,six==1.16.0,subprocess-tee==0.3.5,tenacity==8.2.2,text-unidecode==1.3,typing_extensions==4.7.1,urllib3==2.0.3,wcmatch==8.4.1,yamllint==1.26.3,zipp==3.15.0
py37-ansible210 run-test-pre: PYTHONHASHSEED='3405589243'
py37-ansible210 run-test: commands[0] | molecule test -s compatibility --destroy always
CRITICAL 'molecule/compatibility/molecule.yml' glob failed.  Exiting.
ERROR: InvocationError for command /opt/vector-role/.tox/py37-ansible210/bin/molecule test -s compatibility --destroy always (exited with code 1)
py37-ansible30 create: /opt/vector-role/.tox/py37-ansible30
py37-ansible30 installdeps: -rtox-requirements.txt, ansible<3.1
py37-ansible30 installed: ansible==3.0.0,ansible-base==2.10.17,ansible-compat==1.0.0,ansible-lint==5.1.3,arrow==1.2.3,bcrypt==4.0.1,binaryornot==0.4.4,bracex==2.3.post1,cached-property==1.5.2,Cerberus==1.3.2,certifi==2023.5.7,cffi==1.15.1,chardet==5.1.0,charset-normalizer==3.2.0,click==8.1.5,click-help-colors==0.9.1,cookiecutter==2.2.3,cryptography==41.0.2,distro==1.8.0,enrich==1.2.7,idna==3.4,importlib-metadata==6.7.0,Jinja2==3.1.2,jmespath==1.0.1,lxml==4.9.3,markdown-it-py==2.2.0,MarkupSafe==2.1.3,mdurl==0.1.2,molecule==3.5.2,molecule-podman==1.1.0,packaging==23.1,paramiko==2.12.0,pathspec==0.11.1,pluggy==1.2.0,pycparser==2.21,Pygments==2.15.1,PyNaCl==1.5.0,python-dateutil==2.8.2,python-slugify==8.0.1,PyYAML==5.4.1,requests==2.31.0,rich==13.4.2,ruamel.yaml==0.17.32,ruamel.yaml.clib==0.2.7,selinux==0.2.1,six==1.16.0,subprocess-tee==0.3.5,tenacity==8.2.2,text-unidecode==1.3,typing_extensions==4.7.1,urllib3==2.0.3,wcmatch==8.4.1,yamllint==1.26.3,zipp==3.15.0
py37-ansible30 run-test-pre: PYTHONHASHSEED='3405589243'
py37-ansible30 run-test: commands[0] | molecule test -s compatibility --destroy always
CRITICAL 'molecule/compatibility/molecule.yml' glob failed.  Exiting.
ERROR: InvocationError for command /opt/vector-role/.tox/py37-ansible30/bin/molecule test -s compatibility --destroy always (exited with code 1)
py39-ansible210 create: /opt/vector-role/.tox/py39-ansible210
py39-ansible210 installdeps: -rtox-requirements.txt, ansible<3.0
py39-ansible210 installed: ansible==2.10.7,ansible-base==2.10.17,ansible-compat==4.1.2,ansible-core==2.15.2,ansible-lint==5.1.3,arrow==1.2.3,attrs==23.1.0,bcrypt==4.0.1,binaryornot==0.4.4,bracex==2.3.post1,Cerberus==1.3.2,certifi==2023.5.7,cffi==1.15.1,chardet==5.1.0,charset-normalizer==3.2.0,click==8.1.5,click-help-colors==0.9.1,cookiecutter==2.2.3,cryptography==41.0.2,distro==1.8.0,enrich==1.2.7,idna==3.4,importlib-resources==5.0.7,Jinja2==3.1.2,jmespath==1.0.1,jsonschema==4.18.4,jsonschema-specifications==2023.6.1,lxml==4.9.3,markdown-it-py==3.0.0,MarkupSafe==2.1.3,mdurl==0.1.2,molecule==3.5.2,molecule-podman==2.0.0,packaging==23.1,paramiko==2.12.0,pathspec==0.11.1,pluggy==1.2.0,pycparser==2.21,Pygments==2.15.1,PyNaCl==1.5.0,python-dateutil==2.8.2,python-slugify==8.0.1,PyYAML==5.4.1,referencing==0.30.0,requests==2.31.0,resolvelib==1.0.1,rich==13.4.2,rpds-py==0.9.2,ruamel.yaml==0.17.32,ruamel.yaml.clib==0.2.7,selinux==0.3.0,six==1.16.0,subprocess-tee==0.4.1,tenacity==8.2.2,text-unidecode==1.3,typing_extensions==4.7.1,urllib3==2.0.3,wcmatch==8.4.1,yamllint==1.26.3
py39-ansible210 run-test-pre: PYTHONHASHSEED='3405589243'
py39-ansible210 run-test: commands[0] | molecule test -s compatibility --destroy always
CRITICAL 'molecule/compatibility/molecule.yml' glob failed.  Exiting.
ERROR: InvocationError for command /opt/vector-role/.tox/py39-ansible210/bin/molecule test -s compatibility --destroy always (exited with code 1)
py39-ansible30 create: /opt/vector-role/.tox/py39-ansible30
py39-ansible30 installdeps: -rtox-requirements.txt, ansible<3.1
py39-ansible30 installed: ansible==3.0.0,ansible-base==2.10.17,ansible-compat==4.1.2,ansible-core==2.15.2,ansible-lint==5.1.3,arrow==1.2.3,attrs==23.1.0,bcrypt==4.0.1,binaryornot==0.4.4,bracex==2.3.post1,Cerberus==1.3.2,certifi==2023.5.7,cffi==1.15.1,chardet==5.1.0,charset-normalizer==3.2.0,click==8.1.5,click-help-colors==0.9.1,cookiecutter==2.2.3,cryptography==41.0.2,distro==1.8.0,enrich==1.2.7,idna==3.4,importlib-resources==5.0.7,Jinja2==3.1.2,jmespath==1.0.1,jsonschema==4.18.4,jsonschema-specifications==2023.6.1,lxml==4.9.3,markdown-it-py==3.0.0,MarkupSafe==2.1.3,mdurl==0.1.2,molecule==3.5.2,molecule-podman==2.0.0,packaging==23.1,paramiko==2.12.0,pathspec==0.11.1,pluggy==1.2.0,pycparser==2.21,Pygments==2.15.1,PyNaCl==1.5.0,python-dateutil==2.8.2,python-slugify==8.0.1,PyYAML==5.4.1,referencing==0.30.0,requests==2.31.0,resolvelib==1.0.1,rich==13.4.2,rpds-py==0.9.2,ruamel.yaml==0.17.32,ruamel.yaml.clib==0.2.7,selinux==0.3.0,six==1.16.0,subprocess-tee==0.4.1,tenacity==8.2.2,text-unidecode==1.3,typing_extensions==4.7.1,urllib3==2.0.3,wcmatch==8.4.1,yamllint==1.26.3
py39-ansible30 run-test-pre: PYTHONHASHSEED='3405589243'
py39-ansible30 run-test: commands[0] | molecule test -s compatibility --destroy always
CRITICAL 'molecule/compatibility/molecule.yml' glob failed.  Exiting.
ERROR: InvocationError for command /opt/vector-role/.tox/py39-ansible30/bin/molecule test -s compatibility --destroy always (exited with code 1)
_____________________________________________________________________________________________________________________________________________________ summary _____________________________________________________________________________________________________________________________________________________
ERROR:   py37-ansible210: commands failed
ERROR:   py37-ansible30: commands failed
ERROR:   py39-ansible210: commands failed
ERROR:   py39-ansible30: commands failed
````   
# Задача   
4. Создайте облегчённый сценарий для molecule с драйвером molecule_podman. Проверьте его на исполнимость.   

## Ответ   
````   
[netology@dz5 vector-role]$ molecule init scenario centos_7 --driver-name podman
INFO     Initializing new scenario centos_7...
INFO     Initialized scenario in /opt/vector-role/molecule/centos_7 successfully.
````   

# Задача   
5. Пропишите правильную команду в tox.ini, чтобы запускался облегчённый сценарий.   

## Ответ   
````   
[netology@dz5 vector-role]$ molecule init scenario centos_7 --driver-name podman
INFO     Initializing new scenario centos_7...
INFO     Initialized scenario in /opt/vector-role/molecule/centos_7 successfully.
````   
# Задача   
6. Пропишите правильную команду в tox.ini, чтобы запускался облегчённый сценарий.   

## Ответ  
[tox.ini](https://github.com/tomaevmax/vector-role/blob/master/tox.ini)

# Задача   
7. Запустите команду tox. Убедитесь, что всё отработало успешно.   

## Ответ  

````   
[netology@dz5 ~]$ docker run --privileged=True -v /opt/vector-role:/opt/vector-role -w /opt/vector-role -it aragast/netology:latest /bin/bash
[root@8c3d00e61538 vector-role]# tox
py37-ansible210 installed: ansible==2.10.7,ansible-base==2.10.17,ansible-compat==1.0.0,ansible-lint==5.1.3,arrow==1.2.3,bcrypt==4.0.1,binaryornot==0.4.4,bracex==2.3.post1,cached-property==1.5.2,Cerberus==1.3.2,certifi==2023.5.7,cffi==1.15.1,chardet==5.1.0,charset-normalizer==3.2.0,click==8.1.5,click-help-colors==0.9.1,cookiecutter==2.2.3,cryptography==41.0.2,distro==1.8.0,enrich==1.2.7,idna==3.4,importlib-metadata==6.7.0,Jinja2==3.1.2,jmespath==1.0.1,lxml==4.9.3,markdown-it-py==2.2.0,MarkupSafe==2.1.3,mdurl==0.1.2,molecule==3.5.2,molecule-podman==1.1.0,packaging==23.1,paramiko==2.12.0,pathspec==0.11.1,pluggy==1.2.0,pycparser==2.21,Pygments==2.15.1,PyNaCl==1.5.0,python-dateutil==2.8.2,python-slugify==8.0.1,PyYAML==5.4.1,requests==2.31.0,rich==13.4.2,ruamel.yaml==0.17.32,ruamel.yaml.clib==0.2.7,selinux==0.2.1,six==1.16.0,subprocess-tee==0.3.5,tenacity==8.2.2,text-unidecode==1.3,typing_extensions==4.7.1,urllib3==2.0.3,wcmatch==8.4.1,yamllint==1.26.3,zipp==3.15.0
py37-ansible210 run-test-pre: PYTHONHASHSEED='1999751604'
py37-ansible210 run-test: commands[0] | molecule test -s centos_7 --destroy always
INFO     centos_7 scenario test matrix: dependency, lint, cleanup, destroy, syntax, create, prepare, converge, idempotence, side_effect, verify, cleanup, destroy
INFO     Performing prerun...
INFO     Set ANSIBLE_LIBRARY=/root/.cache/ansible-compat/b984a4/modules:/root/.ansible/plugins/modules:/usr/share/ansible/plugins/modules
INFO     Set ANSIBLE_COLLECTIONS_PATH=/root/.cache/ansible-compat/b984a4/collections:/root/.ansible/collections:/usr/share/ansible/collections
INFO     Set ANSIBLE_ROLES_PATH=/root/.cache/ansible-compat/b984a4/roles:/root/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles
INFO     Running centos_7 > dependency
INFO     Running ansible-galaxy collection install -v --force containers.podman:>=1.7.0
INFO     Running ansible-galaxy collection install -v --force ansible.posix:>=1.3.0
WARNING  Skipping, missing the requirements file.
WARNING  Skipping, missing the requirements file.
INFO     Running centos_7 > lint
INFO     Lint is disabled.
INFO     Running centos_7 > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running centos_7 > destroy
INFO     Sanity checks: 'podman'

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item={'command': '/sbin/init', 'image': 'docker.io/centos:7', 'name': 'pod_centos', 'pre_build_image': False, 'privileged': True, 'tmpfs': ['/run', '/tmp'], 'volumes': ['/sys/fs/cgroup:/sys/fs/cgroup:ro']})

TASK [Wait for instance(s) deletion to complete] *******************************
changed: [localhost] => (item={'started': 1, 'finished': 0, 'ansible_job_id': '399545517234.77', 'results_file': '/root/.ansible_async/399545517234.77', 'changed': True, 'failed': False, 'item': {'command': '/sbin/init', 'image': 'docker.io/centos:7', 'name': 'pod_centos', 'pre_build_image': False, 'privileged': True, 'tmpfs': ['/run', '/tmp'], 'volumes': ['/sys/fs/cgroup:/sys/fs/cgroup:ro']}, 'ansible_loop_var': 'item'})

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Running centos_7 > syntax

playbook: /opt/vector-role/molecule/centos_7/converge.yml
INFO     Running centos_7 > create

PLAY [Create] ******************************************************************

TASK [get podman executable path] **********************************************
ok: [localhost]

TASK [save path to executable as fact] *****************************************
ok: [localhost]

TASK [Log into a container registry] *******************************************
skipping: [localhost] => (item="pod_centos registry username: None specified") 

TASK [Check presence of custom Dockerfiles] ************************************
ok: [localhost] => (item=Dockerfile: None specified)

TASK [Create Dockerfiles from image names] *************************************
changed: [localhost] => (item="Dockerfile: None specified; Image: docker.io/centos:7")

TASK [Discover local Podman images] ********************************************
ok: [localhost] => (item=pod_centos)

TASK [Build an Ansible compatible image] ***************************************
FAILED - RETRYING: Build an Ansible compatible image (3 retries left).
FAILED - RETRYING: Build an Ansible compatible image (2 retries left).
FAILED - RETRYING: Build an Ansible compatible image (1 retries left).
failed: [localhost] (item=docker.io/centos:7) => {"ansible_loop_var": "item", "attempts": 3, "changed": true, "cmd": ["/usr/bin/podman", "build", "-f", "/root/.cache/molecule/vector-role/centos_7/Dockerfile_docker_io_centos_7", "-t", "molecule_local/docker.io/centos:7"], "delta": "0:00:01.314628", "end": "2023-07-18 16:54:31.029906", "item": {"ansible_index_var": "i", "ansible_loop_var": "item", "changed": true, "checksum": "744f2bdb88b2569f9f3ef6f264089342eb42494a", "dest": "/root/.cache/molecule/vector-role/centos_7/Dockerfile_docker_io_centos_7", "diff": [], "failed": false, "gid": 0, "group": "root", "i": 0, "invocation": {"module_args": {"_original_basename": "Dockerfile.j2", "attributes": null, "backup": false, "checksum": "744f2bdb88b2569f9f3ef6f264089342eb42494a", "content": null, "dest": "/root/.cache/molecule/vector-role/centos_7/Dockerfile_docker_io_centos_7", "directory_mode": null, "follow": false, "force": true, "group": null, "local_follow": null, "mode": "0600", "owner": null, "remote_src": null, "selevel": null, "serole": null, "setype": null, "seuser": null, "src": "/root/.ansible/tmp/ansible-tmp-1689699160.5516741-170-17154342983226/source", "unsafe_writes": false, "validate": null}}, "item": {"command": "/sbin/init", "image": "docker.io/centos:7", "name": "pod_centos", "pre_build_image": false, "privileged": true, "tmpfs": ["/run", "/tmp"], "volumes": ["/sys/fs/cgroup:/sys/fs/cgroup:ro"]}, "md5sum": "8bdab67f4456febb5a3d4c617f07eb46", "mode": "0600", "owner": "root", "size": 1047, "src": "/root/.ansible/tmp/ansible-tmp-1689699160.5516741-170-17154342983226/source", "state": "file", "uid": 0}, "msg": "non-zero return code", "rc": 125, "start": "2023-07-18 16:54:29.715278", "stderr": "time=\"2023-07-18T16:54:30Z\" level=warning msg=\"Failed to load cached network config: network podman not found in CNI cache, falling back to loading network podman from disk\"\nerror running container: did not get container start message from parent: EOF\nError: error building at STEP \"RUN if [ $(command -v apt-get) ]; then export DEBIAN_FRONTEND=noninteractive && apt-get update && apt-get install -y python3 sudo bash ca-certificates iproute2 python3-apt aptitude && apt-get clean && rm -rf /var/lib/apt/lists/*;     elif [ $(command -v dnf) ]; then dnf makecache && dnf --assumeyes install /usr/bin/python3 /usr/bin/python3-config /usr/bin/dnf-3 sudo bash iproute && dnf clean all;     elif [ $(command -v yum) ]; then yum makecache fast && yum install -y /usr/bin/python /usr/bin/python2-config sudo yum-plugin-ovl bash iproute && sed -i 's/plugins=0/plugins=1/g' /etc/yum.conf && yum clean all;     elif [ $(command -v zypper) ]; then zypper refresh && zypper install -y python3 sudo bash iproute2 && zypper clean -a;     elif [ $(command -v apk) ]; then apk update && apk add --no-cache python3 sudo bash ca-certificates;     elif [ $(command -v xbps-install) ]; then xbps-install -Syu && xbps-install -y python3 sudo bash ca-certificates iproute2 && xbps-remove -O; fi\": plugin type=\"bridge\" failed (add): cni plugin bridge failed: running [/usr/sbin/iptables -t nat -A POSTROUTING -s 10.88.0.5 -j CNI-13906c23ec2ab7f25af01380 -m comment --comment name: \"podman\" id: \"buildah-buildah1215171404\" --wait]: exit status 4: iptables v1.8.4 (nf_tables):  RULE_APPEND failed (Invalid argument): rule in chain POSTROUTING", "stderr_lines": ["time=\"2023-07-18T16:54:30Z\" level=warning msg=\"Failed to load cached network config: network podman not found in CNI cache, falling back to loading network podman from disk\"", "error running container: did not get container start message from parent: EOF", "Error: error building at STEP \"RUN if [ $(command -v apt-get) ]; then export DEBIAN_FRONTEND=noninteractive && apt-get update && apt-get install -y python3 sudo bash ca-certificates iproute2 python3-apt aptitude && apt-get clean && rm -rf /var/lib/apt/lists/*;     elif [ $(command -v dnf) ]; then dnf makecache && dnf --assumeyes install /usr/bin/python3 /usr/bin/python3-config /usr/bin/dnf-3 sudo bash iproute && dnf clean all;     elif [ $(command -v yum) ]; then yum makecache fast && yum install -y /usr/bin/python /usr/bin/python2-config sudo yum-plugin-ovl bash iproute && sed -i 's/plugins=0/plugins=1/g' /etc/yum.conf && yum clean all;     elif [ $(command -v zypper) ]; then zypper refresh && zypper install -y python3 sudo bash iproute2 && zypper clean -a;     elif [ $(command -v apk) ]; then apk update && apk add --no-cache python3 sudo bash ca-certificates;     elif [ $(command -v xbps-install) ]; then xbps-install -Syu && xbps-install -y python3 sudo bash ca-certificates iproute2 && xbps-remove -O; fi\": plugin type=\"bridge\" failed (add): cni plugin bridge failed: running [/usr/sbin/iptables -t nat -A POSTROUTING -s 10.88.0.5 -j CNI-13906c23ec2ab7f25af01380 -m comment --comment name: \"podman\" id: \"buildah-buildah1215171404\" --wait]: exit status 4: iptables v1.8.4 (nf_tables):  RULE_APPEND failed (Invalid argument): rule in chain POSTROUTING"], "stdout": "STEP 1/2: FROM docker.io/centos:7\nSTEP 2/2: RUN if [ $(command -v apt-get) ]; then export DEBIAN_FRONTEND=noninteractive && apt-get update && apt-get install -y python3 sudo bash ca-certificates iproute2 python3-apt aptitude && apt-get clean && rm -rf /var/lib/apt/lists/*;     elif [ $(command -v dnf) ]; then dnf makecache && dnf --assumeyes install /usr/bin/python3 /usr/bin/python3-config /usr/bin/dnf-3 sudo bash iproute && dnf clean all;     elif [ $(command -v yum) ]; then yum makecache fast && yum install -y /usr/bin/python /usr/bin/python2-config sudo yum-plugin-ovl bash iproute && sed -i 's/plugins=0/plugins=1/g' /etc/yum.conf && yum clean all;     elif [ $(command -v zypper) ]; then zypper refresh && zypper install -y python3 sudo bash iproute2 && zypper clean -a;     elif [ $(command -v apk) ]; then apk update && apk add --no-cache python3 sudo bash ca-certificates;     elif [ $(command -v xbps-install) ]; then xbps-install -Syu && xbps-install -y python3 sudo bash ca-certificates iproute2 && xbps-remove -O; fi", "stdout_lines": ["STEP 1/2: FROM docker.io/centos:7", "STEP 2/2: RUN if [ $(command -v apt-get) ]; then export DEBIAN_FRONTEND=noninteractive && apt-get update && apt-get install -y python3 sudo bash ca-certificates iproute2 python3-apt aptitude && apt-get clean && rm -rf /var/lib/apt/lists/*;     elif [ $(command -v dnf) ]; then dnf makecache && dnf --assumeyes install /usr/bin/python3 /usr/bin/python3-config /usr/bin/dnf-3 sudo bash iproute && dnf clean all;     elif [ $(command -v yum) ]; then yum makecache fast && yum install -y /usr/bin/python /usr/bin/python2-config sudo yum-plugin-ovl bash iproute && sed -i 's/plugins=0/plugins=1/g' /etc/yum.conf && yum clean all;     elif [ $(command -v zypper) ]; then zypper refresh && zypper install -y python3 sudo bash iproute2 && zypper clean -a;     elif [ $(command -v apk) ]; then apk update && apk add --no-cache python3 sudo bash ca-certificates;     elif [ $(command -v xbps-install) ]; then xbps-install -Syu && xbps-install -y python3 sudo bash ca-certificates iproute2 && xbps-remove -O; fi"]}

PLAY RECAP *********************************************************************
localhost                  : ok=5    changed=1    unreachable=0    failed=1    skipped=1    rescued=0    ignored=0

CRITICAL Ansible return code was 2, command was: ['ansible-playbook', '--inventory', '/root/.cache/molecule/vector-role/centos_7/inventory', '--skip-tags', 'molecule-notest,notest', '/opt/vector-role/.tox/py37-ansible210/lib/python3.7/site-packages/molecule_podman/playbooks/create.yml']
WARNING  An error occurred during the test sequence action: 'create'. Cleaning up.
INFO     Running centos_7 > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running centos_7 > destroy

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item={'command': '/sbin/init', 'image': 'docker.io/centos:7', 'name': 'pod_centos', 'pre_build_image': False, 'privileged': True, 'tmpfs': ['/run', '/tmp'], 'volumes': ['/sys/fs/cgroup:/sys/fs/cgroup:ro']})

TASK [Wait for instance(s) deletion to complete] *******************************
changed: [localhost] => (item={'started': 1, 'finished': 0, 'ansible_job_id': '606611022025.973', 'results_file': '/root/.ansible_async/606611022025.973', 'changed': True, 'failed': False, 'item': {'command': '/sbin/init', 'image': 'docker.io/centos:7', 'name': 'pod_centos', 'pre_build_image': False, 'privileged': True, 'tmpfs': ['/run', '/tmp'], 'volumes': ['/sys/fs/cgroup:/sys/fs/cgroup:ro']}, 'ansible_loop_var': 'item'})

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Pruning extra files from scenario ephemeral directory
ERROR: InvocationError for command /opt/vector-role/.tox/py37-ansible210/bin/molecule test -s centos_7 --destroy always (exited with code 1)
py37-ansible30 installed: ansible==3.0.0,ansible-base==2.10.17,ansible-compat==1.0.0,ansible-lint==5.1.3,arrow==1.2.3,bcrypt==4.0.1,binaryornot==0.4.4,bracex==2.3.post1,cached-property==1.5.2,Cerberus==1.3.2,certifi==2023.5.7,cffi==1.15.1,chardet==5.1.0,charset-normalizer==3.2.0,click==8.1.5,click-help-colors==0.9.1,cookiecutter==2.2.3,cryptography==41.0.2,distro==1.8.0,enrich==1.2.7,idna==3.4,importlib-metadata==6.7.0,Jinja2==3.1.2,jmespath==1.0.1,lxml==4.9.3,markdown-it-py==2.2.0,MarkupSafe==2.1.3,mdurl==0.1.2,molecule==3.5.2,molecule-podman==1.1.0,packaging==23.1,paramiko==2.12.0,pathspec==0.11.1,pluggy==1.2.0,pycparser==2.21,Pygments==2.15.1,PyNaCl==1.5.0,python-dateutil==2.8.2,python-slugify==8.0.1,PyYAML==5.4.1,requests==2.31.0,rich==13.4.2,ruamel.yaml==0.17.32,ruamel.yaml.clib==0.2.7,selinux==0.2.1,six==1.16.0,subprocess-tee==0.3.5,tenacity==8.2.2,text-unidecode==1.3,typing_extensions==4.7.1,urllib3==2.0.3,wcmatch==8.4.1,yamllint==1.26.3,zipp==3.15.0
py37-ansible30 run-test-pre: PYTHONHASHSEED='1999751604'
py37-ansible30 run-test: commands[0] | molecule test -s centos_7 --destroy always
INFO     centos_7 scenario test matrix: dependency, lint, cleanup, destroy, syntax, create, prepare, converge, idempotence, side_effect, verify, cleanup, destroy
INFO     Performing prerun...
INFO     Set ANSIBLE_LIBRARY=/root/.cache/ansible-compat/b984a4/modules:/root/.ansible/plugins/modules:/usr/share/ansible/plugins/modules
INFO     Set ANSIBLE_COLLECTIONS_PATH=/root/.cache/ansible-compat/b984a4/collections:/root/.ansible/collections:/usr/share/ansible/collections
INFO     Set ANSIBLE_ROLES_PATH=/root/.cache/ansible-compat/b984a4/roles:/root/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles
INFO     Running centos_7 > dependency
WARNING  Skipping, missing the requirements file.
WARNING  Skipping, missing the requirements file.
INFO     Running centos_7 > lint
INFO     Lint is disabled.
INFO     Running centos_7 > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running centos_7 > destroy
INFO     Sanity checks: 'podman'

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item={'command': '/sbin/init', 'image': 'docker.io/centos:7', 'name': 'pod_centos', 'pre_build_image': False, 'privileged': True, 'tmpfs': ['/run', '/tmp'], 'volumes': ['/sys/fs/cgroup:/sys/fs/cgroup:ro']})

TASK [Wait for instance(s) deletion to complete] *******************************
changed: [localhost] => (item={'started': 1, 'finished': 0, 'ansible_job_id': '374268908817.1056', 'results_file': '/root/.ansible_async/374268908817.1056', 'changed': True, 'failed': False, 'item': {'command': '/sbin/init', 'image': 'docker.io/centos:7', 'name': 'pod_centos', 'pre_build_image': False, 'privileged': True, 'tmpfs': ['/run', '/tmp'], 'volumes': ['/sys/fs/cgroup:/sys/fs/cgroup:ro']}, 'ansible_loop_var': 'item'})

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Running centos_7 > syntax

playbook: /opt/vector-role/molecule/centos_7/converge.yml
INFO     Running centos_7 > create

PLAY [Create] ******************************************************************

TASK [get podman executable path] **********************************************
ok: [localhost]

TASK [save path to executable as fact] *****************************************
ok: [localhost]

TASK [Log into a container registry] *******************************************
skipping: [localhost] => (item="pod_centos registry username: None specified") 

TASK [Check presence of custom Dockerfiles] ************************************
ok: [localhost] => (item=Dockerfile: None specified)

TASK [Create Dockerfiles from image names] *************************************
changed: [localhost] => (item="Dockerfile: None specified; Image: docker.io/centos:7")

TASK [Discover local Podman images] ********************************************
ok: [localhost] => (item=pod_centos)

TASK [Build an Ansible compatible image] ***************************************
FAILED - RETRYING: Build an Ansible compatible image (3 retries left).
FAILED - RETRYING: Build an Ansible compatible image (2 retries left).
FAILED - RETRYING: Build an Ansible compatible image (1 retries left).
failed: [localhost] (item=docker.io/centos:7) => {"ansible_loop_var": "item", "attempts": 3, "changed": true, "cmd": ["/usr/bin/podman", "build", "-f", "/root/.cache/molecule/vector-role/centos_7/Dockerfile_docker_io_centos_7", "-t", "molecule_local/docker.io/centos:7"], "delta": "0:00:00.788774", "end": "2023-07-18 16:56:15.302112", "item": {"ansible_index_var": "i", "ansible_loop_var": "item", "changed": true, "checksum": "744f2bdb88b2569f9f3ef6f264089342eb42494a", "dest": "/root/.cache/molecule/vector-role/centos_7/Dockerfile_docker_io_centos_7", "diff": [], "failed": false, "gid": 0, "group": "root", "i": 0, "invocation": {"module_args": {"_original_basename": "Dockerfile.j2", "attributes": null, "backup": false, "checksum": "744f2bdb88b2569f9f3ef6f264089342eb42494a", "content": null, "dest": "/root/.cache/molecule/vector-role/centos_7/Dockerfile_docker_io_centos_7", "directory_mode": null, "follow": false, "force": true, "group": null, "local_follow": null, "mode": "0600", "owner": null, "remote_src": null, "selevel": null, "serole": null, "setype": null, "seuser": null, "src": "/root/.ansible/tmp/ansible-tmp-1689699280.2392566-1151-50808385512600/source", "unsafe_writes": false, "validate": null}}, "item": {"command": "/sbin/init", "image": "docker.io/centos:7", "name": "pod_centos", "pre_build_image": false, "privileged": true, "tmpfs": ["/run", "/tmp"], "volumes": ["/sys/fs/cgroup:/sys/fs/cgroup:ro"]}, "md5sum": "8bdab67f4456febb5a3d4c617f07eb46", "mode": "0600", "owner": "root", "size": 1047, "src": "/root/.ansible/tmp/ansible-tmp-1689699280.2392566-1151-50808385512600/source", "state": "file", "uid": 0}, "msg": "non-zero return code", "rc": 125, "start": "2023-07-18 16:56:14.513338", "stderr": "time=\"2023-07-18T16:56:15Z\" level=warning msg=\"Failed to load cached network config: network podman not found in CNI cache, falling back to loading network podman from disk\"\nerror running container: did not get container start message from parent: EOF\nError: error building at STEP \"RUN if [ $(command -v apt-get) ]; then export DEBIAN_FRONTEND=noninteractive && apt-get update && apt-get install -y python3 sudo bash ca-certificates iproute2 python3-apt aptitude && apt-get clean && rm -rf /var/lib/apt/lists/*;     elif [ $(command -v dnf) ]; then dnf makecache && dnf --assumeyes install /usr/bin/python3 /usr/bin/python3-config /usr/bin/dnf-3 sudo bash iproute && dnf clean all;     elif [ $(command -v yum) ]; then yum makecache fast && yum install -y /usr/bin/python /usr/bin/python2-config sudo yum-plugin-ovl bash iproute && sed -i 's/plugins=0/plugins=1/g' /etc/yum.conf && yum clean all;     elif [ $(command -v zypper) ]; then zypper refresh && zypper install -y python3 sudo bash iproute2 && zypper clean -a;     elif [ $(command -v apk) ]; then apk update && apk add --no-cache python3 sudo bash ca-certificates;     elif [ $(command -v xbps-install) ]; then xbps-install -Syu && xbps-install -y python3 sudo bash ca-certificates iproute2 && xbps-remove -O; fi\": plugin type=\"bridge\" failed (add): cni plugin bridge failed: running [/usr/sbin/iptables -t nat -A POSTROUTING -s 10.88.0.9 -j CNI-7a75636b2f6ee6c4543c2f9b -m comment --comment name: \"podman\" id: \"buildah-buildah1072177464\" --wait]: exit status 4: iptables v1.8.4 (nf_tables):  RULE_APPEND failed (Invalid argument): rule in chain POSTROUTING", "stderr_lines": ["time=\"2023-07-18T16:56:15Z\" level=warning msg=\"Failed to load cached network config: network podman not found in CNI cache, falling back to loading network podman from disk\"", "error running container: did not get container start message from parent: EOF", "Error: error building at STEP \"RUN if [ $(command -v apt-get) ]; then export DEBIAN_FRONTEND=noninteractive && apt-get update && apt-get install -y python3 sudo bash ca-certificates iproute2 python3-apt aptitude && apt-get clean && rm -rf /var/lib/apt/lists/*;     elif [ $(command -v dnf) ]; then dnf makecache && dnf --assumeyes install /usr/bin/python3 /usr/bin/python3-config /usr/bin/dnf-3 sudo bash iproute && dnf clean all;     elif [ $(command -v yum) ]; then yum makecache fast && yum install -y /usr/bin/python /usr/bin/python2-config sudo yum-plugin-ovl bash iproute && sed -i 's/plugins=0/plugins=1/g' /etc/yum.conf && yum clean all;     elif [ $(command -v zypper) ]; then zypper refresh && zypper install -y python3 sudo bash iproute2 && zypper clean -a;     elif [ $(command -v apk) ]; then apk update && apk add --no-cache python3 sudo bash ca-certificates;     elif [ $(command -v xbps-install) ]; then xbps-install -Syu && xbps-install -y python3 sudo bash ca-certificates iproute2 && xbps-remove -O; fi\": plugin type=\"bridge\" failed (add): cni plugin bridge failed: running [/usr/sbin/iptables -t nat -A POSTROUTING -s 10.88.0.9 -j CNI-7a75636b2f6ee6c4543c2f9b -m comment --comment name: \"podman\" id: \"buildah-buildah1072177464\" --wait]: exit status 4: iptables v1.8.4 (nf_tables):  RULE_APPEND failed (Invalid argument): rule in chain POSTROUTING"], "stdout": "STEP 1/2: FROM docker.io/centos:7\nSTEP 2/2: RUN if [ $(command -v apt-get) ]; then export DEBIAN_FRONTEND=noninteractive && apt-get update && apt-get install -y python3 sudo bash ca-certificates iproute2 python3-apt aptitude && apt-get clean && rm -rf /var/lib/apt/lists/*;     elif [ $(command -v dnf) ]; then dnf makecache && dnf --assumeyes install /usr/bin/python3 /usr/bin/python3-config /usr/bin/dnf-3 sudo bash iproute && dnf clean all;     elif [ $(command -v yum) ]; then yum makecache fast && yum install -y /usr/bin/python /usr/bin/python2-config sudo yum-plugin-ovl bash iproute && sed -i 's/plugins=0/plugins=1/g' /etc/yum.conf && yum clean all;     elif [ $(command -v zypper) ]; then zypper refresh && zypper install -y python3 sudo bash iproute2 && zypper clean -a;     elif [ $(command -v apk) ]; then apk update && apk add --no-cache python3 sudo bash ca-certificates;     elif [ $(command -v xbps-install) ]; then xbps-install -Syu && xbps-install -y python3 sudo bash ca-certificates iproute2 && xbps-remove -O; fi", "stdout_lines": ["STEP 1/2: FROM docker.io/centos:7", "STEP 2/2: RUN if [ $(command -v apt-get) ]; then export DEBIAN_FRONTEND=noninteractive && apt-get update && apt-get install -y python3 sudo bash ca-certificates iproute2 python3-apt aptitude && apt-get clean && rm -rf /var/lib/apt/lists/*;     elif [ $(command -v dnf) ]; then dnf makecache && dnf --assumeyes install /usr/bin/python3 /usr/bin/python3-config /usr/bin/dnf-3 sudo bash iproute && dnf clean all;     elif [ $(command -v yum) ]; then yum makecache fast && yum install -y /usr/bin/python /usr/bin/python2-config sudo yum-plugin-ovl bash iproute && sed -i 's/plugins=0/plugins=1/g' /etc/yum.conf && yum clean all;     elif [ $(command -v zypper) ]; then zypper refresh && zypper install -y python3 sudo bash iproute2 && zypper clean -a;     elif [ $(command -v apk) ]; then apk update && apk add --no-cache python3 sudo bash ca-certificates;     elif [ $(command -v xbps-install) ]; then xbps-install -Syu && xbps-install -y python3 sudo bash ca-certificates iproute2 && xbps-remove -O; fi"]}

PLAY RECAP *********************************************************************
localhost                  : ok=5    changed=1    unreachable=0    failed=1    skipped=1    rescued=0    ignored=0

CRITICAL Ansible return code was 2, command was: ['ansible-playbook', '--inventory', '/root/.cache/molecule/vector-role/centos_7/inventory', '--skip-tags', 'molecule-notest,notest', '/opt/vector-role/.tox/py37-ansible30/lib/python3.7/site-packages/molecule_podman/playbooks/create.yml']
WARNING  An error occurred during the test sequence action: 'create'. Cleaning up.
INFO     Running centos_7 > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running centos_7 > destroy

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item={'command': '/sbin/init', 'image': 'docker.io/centos:7', 'name': 'pod_centos', 'pre_build_image': False, 'privileged': True, 'tmpfs': ['/run', '/tmp'], 'volumes': ['/sys/fs/cgroup:/sys/fs/cgroup:ro']})

TASK [Wait for instance(s) deletion to complete] *******************************
changed: [localhost] => (item={'started': 1, 'finished': 0, 'ansible_job_id': '383664502960.1941', 'results_file': '/root/.ansible_async/383664502960.1941', 'changed': True, 'failed': False, 'item': {'command': '/sbin/init', 'image': 'docker.io/centos:7', 'name': 'pod_centos', 'pre_build_image': False, 'privileged': True, 'tmpfs': ['/run', '/tmp'], 'volumes': ['/sys/fs/cgroup:/sys/fs/cgroup:ro']}, 'ansible_loop_var': 'item'})

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Pruning extra files from scenario ephemeral directory
ERROR: InvocationError for command /opt/vector-role/.tox/py37-ansible30/bin/molecule test -s centos_7 --destroy always (exited with code 1)
py39-ansible210 installed: ansible==2.10.7,ansible-base==2.10.17,ansible-compat==4.1.2,ansible-core==2.15.2,ansible-lint==5.1.3,arrow==1.2.3,attrs==23.1.0,bcrypt==4.0.1,binaryornot==0.4.4,bracex==2.3.post1,Cerberus==1.3.2,certifi==2023.5.7,cffi==1.15.1,chardet==5.1.0,charset-normalizer==3.2.0,click==8.1.5,click-help-colors==0.9.1,cookiecutter==2.2.3,cryptography==41.0.2,distro==1.8.0,enrich==1.2.7,idna==3.4,importlib-resources==5.0.7,Jinja2==3.1.2,jmespath==1.0.1,jsonschema==4.18.4,jsonschema-specifications==2023.6.1,lxml==4.9.3,markdown-it-py==3.0.0,MarkupSafe==2.1.3,mdurl==0.1.2,molecule==3.5.2,molecule-podman==2.0.0,packaging==23.1,paramiko==2.12.0,pathspec==0.11.1,pluggy==1.2.0,pycparser==2.21,Pygments==2.15.1,PyNaCl==1.5.0,python-dateutil==2.8.2,python-slugify==8.0.1,PyYAML==5.4.1,referencing==0.30.0,requests==2.31.0,resolvelib==1.0.1,rich==13.4.2,rpds-py==0.9.2,ruamel.yaml==0.17.32,ruamel.yaml.clib==0.2.7,selinux==0.3.0,six==1.16.0,subprocess-tee==0.4.1,tenacity==8.2.2,text-unidecode==1.3,typing_extensions==4.7.1,urllib3==2.0.3,wcmatch==8.4.1,yamllint==1.26.3
py39-ansible210 run-test-pre: PYTHONHASHSEED='1999751604'
py39-ansible210 run-test: commands[0] | molecule test -s centos_7 --destroy always
INFO     centos_7 scenario test matrix: dependency, lint, cleanup, destroy, syntax, create, prepare, converge, idempotence, side_effect, verify, cleanup, destroy
INFO     Performing prerun...
INFO     Set ANSIBLE_LIBRARY=/root/.cache/ansible-compat/f5bcd7/modules:/root/.ansible/plugins/modules:/usr/share/ansible/plugins/modules
INFO     Set ANSIBLE_COLLECTIONS_PATH=/root/.cache/ansible-compat/f5bcd7/collections:/root/.ansible/collections:/usr/share/ansible/collections
INFO     Set ANSIBLE_ROLES_PATH=/root/.cache/ansible-compat/f5bcd7/roles:/root/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles
INFO     Running centos_7 > dependency
INFO     Running from /opt/vector-role : ansible-galaxy collection install -vvv containers.podman:>=1.7.0
WARNING  Retrying execution failure 250 of: ansible-galaxy collection install -vvv containers.podman:>=1.7.0
ERROR    Command returned 250 code:
the full traceback was:

Traceback (most recent call last):
  File "/opt/vector-role/.tox/py39-ansible210/bin/ansible-galaxy", line 92, in <module>
    mycli = getattr(__import__("ansible.cli.%s" % sub, fromlist=), myclass)
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/ansible/cli/galaxy.py", line 24, in <module>
    from ansible.galaxy.collection import (
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/ansible/galaxy/collection/__init__.py", line 90, in <module>
    from ansible.galaxy.collection.concrete_artifact_manager import (
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/ansible/galaxy/collection/concrete_artifact_manager.py", line 30, in <module>
    from ansible.galaxy.api import should_retry_error
ImportError: cannot import name 'should_retry_error' from 'ansible.galaxy.api' (/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/ansible/galaxy/api.py)

[1m[0;31mERROR! Unexpected Exception, this is probably a bug: cannot import name 'should_retry_error' from 'ansible.galaxy.api' (/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/ansible/galaxy/api.py)[1m[0m

Traceback (most recent call last):
  File "/opt/vector-role/.tox/py39-ansible210/bin/molecule", line 8, in <module>
    sys.exit(main())
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/click/core.py", line 1157, in __call__
    return self.main(*args, **kwargs)
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/click/core.py", line 1078, in main
    rv = self.invoke(ctx)
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/click/core.py", line 1688, in invoke
    return _process_result(sub_ctx.command.invoke(sub_ctx))
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/click/core.py", line 1434, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/click/core.py", line 783, in invoke
    return __callback(*args, **kwargs)
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/click/decorators.py", line 33, in new_func
    return f(get_current_context(), *args, **kwargs)
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/molecule/command/test.py", line 159, in test
    base.execute_cmdline_scenarios(scenario_name, args, command_args, ansible_args)
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/molecule/command/base.py", line 118, in execute_cmdline_scenarios
    execute_scenario(scenario)
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/molecule/command/base.py", line 160, in execute_scenario
    execute_subcommand(scenario.config, action)
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/molecule/command/base.py", line 149, in execute_subcommand
    return command(config).execute()
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/molecule/logger.py", line 188, in wrapper
    rt = func(*args, **kwargs)
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/molecule/command/dependency.py", line 74, in execute
    self._config.dependency.execute()
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/molecule/dependency/ansible_galaxy/__init__.py", line 76, in execute
    invoker.execute()
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/molecule/dependency/ansible_galaxy/base.py", line 120, in execute
    super().execute()
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/molecule/dependency/base.py", line 92, in execute
    self._config.runtime.require_collection(name, version)
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/ansible_compat/runtime.py", line 697, in require_collection
    self.install_collection(f"{name}:>={version}" if version else name)
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/ansible_compat/runtime.py", line 437, in install_collection
    raise InvalidPrerequisiteError(msg)
ansible_compat.errors.InvalidPrerequisiteError: Command returned 250 code:
the full traceback was:

Traceback (most recent call last):
  File "/opt/vector-role/.tox/py39-ansible210/bin/ansible-galaxy", line 92, in <module>
    mycli = getattr(__import__("ansible.cli.%s" % sub, fromlist=[myclass]), myclass)
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/ansible/cli/galaxy.py", line 24, in <module>
    from ansible.galaxy.collection import (
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/ansible/galaxy/collection/__init__.py", line 90, in <module>
    from ansible.galaxy.collection.concrete_artifact_manager import (
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/ansible/galaxy/collection/concrete_artifact_manager.py", line 30, in <module>
    from ansible.galaxy.api import should_retry_error
ImportError: cannot import name 'should_retry_error' from 'ansible.galaxy.api' (/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/ansible/galaxy/api.py)

ERROR! Unexpected Exception, this is probably a bug: cannot import name 'should_retry_error' from 'ansible.galaxy.api' (/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/ansible/galaxy/api.py)

ERROR: InvocationError for command /opt/vector-role/.tox/py39-ansible210/bin/molecule test -s centos_7 --destroy always (exited with code 1)
py39-ansible30 installed: ansible==3.0.0,ansible-base==2.10.17,ansible-compat==4.1.2,ansible-core==2.15.2,ansible-lint==5.1.3,arrow==1.2.3,attrs==23.1.0,bcrypt==4.0.1,binaryornot==0.4.4,bracex==2.3.post1,Cerberus==1.3.2,certifi==2023.5.7,cffi==1.15.1,chardet==5.1.0,charset-normalizer==3.2.0,click==8.1.5,click-help-colors==0.9.1,cookiecutter==2.2.3,cryptography==41.0.2,distro==1.8.0,enrich==1.2.7,idna==3.4,importlib-resources==5.0.7,Jinja2==3.1.2,jmespath==1.0.1,jsonschema==4.18.4,jsonschema-specifications==2023.6.1,lxml==4.9.3,markdown-it-py==3.0.0,MarkupSafe==2.1.3,mdurl==0.1.2,molecule==3.5.2,molecule-podman==2.0.0,packaging==23.1,paramiko==2.12.0,pathspec==0.11.1,pluggy==1.2.0,pycparser==2.21,Pygments==2.15.1,PyNaCl==1.5.0,python-dateutil==2.8.2,python-slugify==8.0.1,PyYAML==5.4.1,referencing==0.30.0,requests==2.31.0,resolvelib==1.0.1,rich==13.4.2,rpds-py==0.9.2,ruamel.yaml==0.17.32,ruamel.yaml.clib==0.2.7,selinux==0.3.0,six==1.16.0,subprocess-tee==0.4.1,tenacity==8.2.2,text-unidecode==1.3,typing_extensions==4.7.1,urllib3==2.0.3,wcmatch==8.4.1,yamllint==1.26.3
py39-ansible30 run-test-pre: PYTHONHASHSEED='1999751604'
py39-ansible30 run-test: commands[0] | molecule test -s centos_7 --destroy always
INFO     centos_7 scenario test matrix: dependency, lint, cleanup, destroy, syntax, create, prepare, converge, idempotence, side_effect, verify, cleanup, destroy
INFO     Performing prerun...
INFO     Set ANSIBLE_LIBRARY=/root/.cache/ansible-compat/f5bcd7/modules:/root/.ansible/plugins/modules:/usr/share/ansible/plugins/modules
INFO     Set ANSIBLE_COLLECTIONS_PATH=/root/.cache/ansible-compat/f5bcd7/collections:/root/.ansible/collections:/usr/share/ansible/collections
INFO     Set ANSIBLE_ROLES_PATH=/root/.cache/ansible-compat/f5bcd7/roles:/root/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles
INFO     Running centos_7 > dependency
INFO     Running from /opt/vector-role : ansible-galaxy collection install -vvv containers.podman:>=1.7.0
WARNING  Retrying execution failure 250 of: ansible-galaxy collection install -vvv containers.podman:>=1.7.0
ERROR    Command returned 250 code:
the full traceback was:

Traceback (most recent call last):
  File "/opt/vector-role/.tox/py39-ansible30/bin/ansible-galaxy", line 92, in <module>
    mycli = getattr(__import__("ansible.cli.%s" % sub, fromlist=), myclass)
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/ansible/cli/galaxy.py", line 24, in <module>
    from ansible.galaxy.collection import (
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/ansible/galaxy/collection/__init__.py", line 90, in <module>
    from ansible.galaxy.collection.concrete_artifact_manager import (
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/ansible/galaxy/collection/concrete_artifact_manager.py", line 30, in <module>
    from ansible.galaxy.api import should_retry_error
ImportError: cannot import name 'should_retry_error' from 'ansible.galaxy.api' (/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/ansible/galaxy/api.py)

[1m[0;31mERROR! Unexpected Exception, this is probably a bug: cannot import name 'should_retry_error' from 'ansible.galaxy.api' (/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/ansible/galaxy/api.py)[1m[0m

Traceback (most recent call last):
  File "/opt/vector-role/.tox/py39-ansible30/bin/molecule", line 8, in <module>
    sys.exit(main())
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/click/core.py", line 1157, in __call__
    return self.main(*args, **kwargs)
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/click/core.py", line 1078, in main
    rv = self.invoke(ctx)
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/click/core.py", line 1688, in invoke
    return _process_result(sub_ctx.command.invoke(sub_ctx))
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/click/core.py", line 1434, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/click/core.py", line 783, in invoke
    return __callback(*args, **kwargs)
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/click/decorators.py", line 33, in new_func
    return f(get_current_context(), *args, **kwargs)
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/molecule/command/test.py", line 159, in test
    base.execute_cmdline_scenarios(scenario_name, args, command_args, ansible_args)
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/molecule/command/base.py", line 118, in execute_cmdline_scenarios
    execute_scenario(scenario)
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/molecule/command/base.py", line 160, in execute_scenario
    execute_subcommand(scenario.config, action)
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/molecule/command/base.py", line 149, in execute_subcommand
    return command(config).execute()
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/molecule/logger.py", line 188, in wrapper
    rt = func(*args, **kwargs)
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/molecule/command/dependency.py", line 74, in execute
    self._config.dependency.execute()
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/molecule/dependency/ansible_galaxy/__init__.py", line 76, in execute
    invoker.execute()
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/molecule/dependency/ansible_galaxy/base.py", line 120, in execute
    super().execute()
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/molecule/dependency/base.py", line 92, in execute
    self._config.runtime.require_collection(name, version)
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/ansible_compat/runtime.py", line 697, in require_collection
    self.install_collection(f"{name}:>={version}" if version else name)
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/ansible_compat/runtime.py", line 437, in install_collection
    raise InvalidPrerequisiteError(msg)
ansible_compat.errors.InvalidPrerequisiteError: Command returned 250 code:
the full traceback was:

Traceback (most recent call last):
  File "/opt/vector-role/.tox/py39-ansible30/bin/ansible-galaxy", line 92, in <module>
    mycli = getattr(__import__("ansible.cli.%s" % sub, fromlist=[myclass]), myclass)
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/ansible/cli/galaxy.py", line 24, in <module>
    from ansible.galaxy.collection import (
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/ansible/galaxy/collection/__init__.py", line 90, in <module>
    from ansible.galaxy.collection.concrete_artifact_manager import (
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/ansible/galaxy/collection/concrete_artifact_manager.py", line 30, in <module>
    from ansible.galaxy.api import should_retry_error
ImportError: cannot import name 'should_retry_error' from 'ansible.galaxy.api' (/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/ansible/galaxy/api.py)

ERROR! Unexpected Exception, this is probably a bug: cannot import name 'should_retry_error' from 'ansible.galaxy.api' (/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/ansible/galaxy/api.py)

ERROR: InvocationError for command /opt/vector-role/.tox/py39-ansible30/bin/molecule test -s centos_7 --destroy always (exited with code 1)
_____________________________________________________________________________________________________________________________________________________ summary _____________________________________________________________________________________________________________________________________________________
ERROR:   py37-ansible210: commands failed
ERROR:   py37-ansible30: commands failed
ERROR:   py39-ansible210: commands failed
ERROR:   py39-ansible30: commands failed
````   
# Задача   
7. Добавьте новый тег на коммит с рабочим сценарием в соответствии с семантическим версионированием.   

# Ответ   

[tag 1.0.3](https://github.com/tomaevmax/vector-role/releases/tag/1.0.3)   