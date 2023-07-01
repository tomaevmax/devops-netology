
# Домашнее задание к занятию 2 «Работа с Playbook»   

## Задача   
  Подготовьте свой inventory-файл prod.yml.   

## Ответ    
[prod.yml](/playbook/inventory/prod.yml)  

## Задача  
 Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает vector.   
При создании tasks рекомендую использовать модули: get_url, template, unarchive, file.   
Tasks должны: скачать дистрибутив нужной версии, выполнить распаковку в выбранную директорию, установить vector.   

## Ответ
[site.yml](/playbook/site.yml) 

## Задача  
  Запустите ansible-lint site.yml и исправьте ошибки, если они есть.   

## Ответ   
````
➜  playbook git:(ansible-dz2) ✗ ansible-lint site.yml
WARNING  Listing 1 violation(s) that are fatal
jinja[spacing]: Jinja2 spacing could be improved: create_db.rc != 0 and create_db.rc !=82 -> create_db.rc != 0 and create_db.rc != 82 (warning)
site.yml:35 Jinja2 template rewrite recommendation: `create_db.rc != 0 and create_db.rc != 82`.

Read documentation for instructions on how to ignore specific rule violations.

              Rule Violation Summary               
 count tag            profile rule associated tags 
     1 jinja[spacing] basic   formatting (warning) 

Passed: 0 failure(s), 1 warning(s) on 1 files. Last profile that met the validation criteria was 'min'.
````   
## Задача  
Попробуйте запустить playbook на этом окружении с флагом --check.   

## Ответ   
````   
➜  playbook git:(ansible-dz2) ✗ ansible-playbook -i inventory/prod.yml site.yml --check

PLAY [Install Clickhouse] *********************************************************************************************************************************************

TASK [Gathering Facts] ************************************************************************************************************************************************
The authenticity of host '51.250.2.246 (51.250.2.246)' can't be established.
ED25519 key fingerprint is SHA256:xPs85arnMZHo/8mHTy0Ym7p3XdpXSXxmG6w+l4KM+1A.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
ok: [clickhouse-01]

TASK [Get clickhouse distrib] *****************************************************************************************************************************************
changed: [clickhouse-01] => (item=clickhouse-client)
changed: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "item": "clickhouse-common-static", "msg": "Request failed", "response": "HTTP Error 404: Not Found", "status_code": 404, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get rescue clickhouse distrib] **********************************************************************************************************************************
changed: [clickhouse-01]

TASK [Install clickhouse packages] ************************************************************************************************************************************
fatal: [clickhouse-01]: FAILED! => {"changed": false, "msg": "No RPM file matching 'clickhouse-common-static-22.3.3.44.rpm' found on system", "rc": 127, "results": ["No RPM file matching 'clickhouse-common-static-22.3.3.44.rpm' found on system"]}

PLAY RECAP ************************************************************************************************************************************************************
clickhouse-01              : ok=2    changed=1    unreachable=0    failed=1    skipped=0    rescued=1    ignored=0    
````   
## Задача  
  Запустите playbook на prod.yml окружении с флагом --diff. Убедитесь, что изменения на системе произведены.   

## Ответ   
````   
➜  playbook git:(ansible-dz2) ✗ ansible-playbook -i inventory/prod.yml site.yml --diff 

PLAY [Install Clickhouse] *********************************************************************************************************************************************

TASK [Gathering Facts] ************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Get clickhouse distrib] *****************************************************************************************************************************************
changed: [clickhouse-01] => (item=clickhouse-client)
changed: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "item": "clickhouse-common-static", "msg": "Request failed", "response": "HTTP Error 404: Not Found", "status_code": 404, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get rescue clickhouse distrib] **********************************************************************************************************************************
changed: [clickhouse-01]

TASK [Install clickhouse packages] ************************************************************************************************************************************
changed: [clickhouse-01]

TASK [Flush handlers] *************************************************************************************************************************************************

RUNNING HANDLER [Start clickhouse service] ****************************************************************************************************************************
changed: [clickhouse-01]

TASK [Create database] ************************************************************************************************************************************************
changed: [clickhouse-01]

PLAY [Install Vector] *************************************************************************************************************************************************

TASK [Gathering Facts] ************************************************************************************************************************************************
The authenticity of host '84.201.130.183 (84.201.130.183)' can't be established.
ED25519 key fingerprint is SHA256:RS/0tdYLmFP8OwajngKqNboa/aVU7z7hjyOR65nO6X8.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
ok: [vector-01]

TASK [Get vector distrib] *********************************************************************************************************************************************
changed: [vector-01]

TASK [Install vector packages] ****************************************************************************************************************************************
changed: [vector-01]

TASK [Flush handlers] *************************************************************************************************************************************************

RUNNING HANDLER [Start vector service] ********************************************************************************************************************************
changed: [vector-01]

PLAY RECAP ************************************************************************************************************************************************************
clickhouse-01              : ok=5    changed=4    unreachable=0    failed=0    skipped=0    rescued=1    ignored=0   
vector-01                  : ok=4    changed=3    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
````   
## Задача  
  Повторно запустите playbook с флагом --diff и убедитесь, что playbook идемпотентен.   

## Ответ   
````   
➜  playbook git:(ansible-dz2) ✗ ansible-playbook -i inventory/prod.yml site.yml --diff

PLAY [Install Clickhouse] *********************************************************************************************************************************************

TASK [Gathering Facts] ************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Get clickhouse distrib] *****************************************************************************************************************************************
ok: [clickhouse-01] => (item=clickhouse-client)
ok: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "gid": 1000, "group": "netology", "item": "clickhouse-common-static", "mode": "0777", "msg": "Request failed", "owner": "netology", "response": "HTTP Error 404: Not Found", "secontext": "unconfined_u:object_r:user_home_t:s0", "size": 246310036, "state": "file", "status_code": 404, "uid": 1000, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get rescue clickhouse distrib] **********************************************************************************************************************************
ok: [clickhouse-01]

TASK [Install clickhouse packages] ************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Flush handlers] *************************************************************************************************************************************************

TASK [Create database] ************************************************************************************************************************************************
ok: [clickhouse-01]

PLAY [Install Vector] *************************************************************************************************************************************************

TASK [Gathering Facts] ************************************************************************************************************************************************
ok: [vector-01]

TASK [Get vector distrib] *********************************************************************************************************************************************
ok: [vector-01]

TASK [Install vector packages] ****************************************************************************************************************************************
ok: [vector-01]

TASK [Flush handlers] *************************************************************************************************************************************************

PLAY RECAP ************************************************************************************************************************************************************
clickhouse-01              : ok=4    changed=0    unreachable=0    failed=0    skipped=0    rescued=1    ignored=0   
vector-01                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
````   
## Задача  
 Подготовьте README.md-файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги.   

## Ответ   
[README.md](/playbook/README.md)   

## Задача   
 Готовый playbook выложите в свой репозиторий, поставьте тег 08-ansible-02-playbook на фиксирующий коммит, в ответ предоставьте ссылку на него.   

## Ответ  
[[commit](https://github.com/tomaevmax/devops-netology/commit/02a9e8b36b1d6d80bd2890158c8ec4500e9d48db) 
