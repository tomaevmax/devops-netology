# Домашнее задание к занятию 3 «Использование Ansible»

## Задача
1. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает LightHouse.
2. При создании tasks рекомендую использовать модули: `get_url`, `template`, `yum`, `apt`.
3. Tasks должны: скачать статику LightHouse, установить Nginx или любой другой веб-сервер, настроить его конфиг для открытия LightHouse, запустить веб-сервер.   

## Ответ
[site.yml](/playbook/site.yml) 

## Задача   
  Подготовьте свой inventory-файл prod.yml.   

## Ответ    
[prod.yml](/playbook/inventory/prod.yml)   

## Задача   
5. Запустите `ansible-lint site.yml` и исправьте ошибки, если они есть.

## Ответ    
````   
➜  playbook git:(ansible-dz3) ✗ ansible-lint site.yml
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
6. Попробуйте запустить playbook на этом окружении с флагом `--check`.   

## Ответ   
````   
➜  playbook git:(ansible-dz3) ✗ ansible-playbook -i inventory/prod.yml site.yml --check

PLAY [Install Clickhouse] *****************************************************************************************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ********************************************************************************************************************************************************************************************************************************************************************************************
The authenticity of host '84.252.128.131 (84.252.128.131)' can't be established.
ED25519 key fingerprint is SHA256:j43Xmc8TZxNT/ltpcWRdbKM1+vUQMz+nDG3pxQwuyXU.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
ok: [clickhouse-01]

TASK [Get clickhouse distrib] *************************************************************************************************************************************************************************************************************************************************************************************
changed: [clickhouse-01] => (item=clickhouse-client)
changed: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "item": "clickhouse-common-static", "msg": "Request failed", "response": "HTTP Error 404: Not Found", "status_code": 404, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get rescue clickhouse distrib] ******************************************************************************************************************************************************************************************************************************************************************************
changed: [clickhouse-01]

TASK [Install clickhouse packages] ********************************************************************************************************************************************************************************************************************************************************************************
fatal: [clickhouse-01]: FAILED! => {"changed": false, "msg": "No RPM file matching 'clickhouse-common-static-22.3.3.44.rpm' found on system", "rc": 127, "results": ["No RPM file matching 'clickhouse-common-static-22.3.3.44.rpm' found on system"]}

PLAY RECAP ********************************************************************************************************************************************************************************************************************************************************************************************************
clickhouse-01              : ok=2    changed=1    unreachable=0    failed=1    skipped=0    rescued=1    ignored=0   
````   
## Задача   
7. Запустите playbook на `prod.yml` окружении с флагом `--diff`. Убедитесь, что изменения на системе произведены.   

## Ответ   
````   
➜  playbook git:(ansible-dz3) ✗ ansible-playbook -i inventory/prod.yml site.yml --diff 

PLAY [Install Clickhouse] *****************************************************************************************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ********************************************************************************************************************************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Get clickhouse distrib] *************************************************************************************************************************************************************************************************************************************************************************************
changed: [clickhouse-01] => (item=clickhouse-client)
changed: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "item": "clickhouse-common-static", "msg": "Request failed", "response": "HTTP Error 404: Not Found", "status_code": 404, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get rescue clickhouse distrib] ******************************************************************************************************************************************************************************************************************************************************************************
changed: [clickhouse-01]

TASK [Install clickhouse packages] ********************************************************************************************************************************************************************************************************************************************************************************
changed: [clickhouse-01]

TASK [Flush handlers] *********************************************************************************************************************************************************************************************************************************************************************************************

RUNNING HANDLER [Start clickhouse service] ************************************************************************************************************************************************************************************************************************************************************************
changed: [clickhouse-01]

TASK [Create database] ********************************************************************************************************************************************************************************************************************************************************************************************
changed: [clickhouse-01]

PLAY [Install Vector] *********************************************************************************************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ********************************************************************************************************************************************************************************************************************************************************************************************
The authenticity of host '84.201.133.74 (84.201.133.74)' can't be established.
ED25519 key fingerprint is SHA256:99xZpk4w6a4lNzJy2LYZyqOQAGMp7pFOaf8gdHEJhRg.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
ok: [vector-01]

TASK [Get vector distrib] *****************************************************************************************************************************************************************************************************************************************************************************************
changed: [vector-01]

TASK [Install vector packages] ************************************************************************************************************************************************************************************************************************************************************************************
changed: [vector-01]

TASK [Flush handlers] *********************************************************************************************************************************************************************************************************************************************************************************************

RUNNING HANDLER [Start vector service] ****************************************************************************************************************************************************************************************************************************************************************************
changed: [vector-01]

PLAY [Install nginx] **********************************************************************************************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ********************************************************************************************************************************************************************************************************************************************************************************************
The authenticity of host '51.250.84.211 (51.250.84.211)' can't be established.
ED25519 key fingerprint is SHA256:NxEQFGMxND0iN9LMikCzE1ifDdsjdWiDJgZNYNWtC24.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
ok: [lighthouse-01]

TASK [NGINX | Install epel-release] *******************************************************************************************************************************************************************************************************************************************************************************
changed: [lighthouse-01]

TASK [NGINX | Install nginx] **************************************************************************************************************************************************************************************************************************************************************************************
changed: [lighthouse-01]

TASK [NGINX | Create general config] ******************************************************************************************************************************************************************************************************************************************************************************
--- before: /etc/nginx/nginx.conf
+++ after: /Users/maksimtomaev/.ansible/tmp/ansible-local-71214oh1ky47i/tmpz3mkkylj/nginx.conf.j2
@@ -1,9 +1,6 @@
-# For more information on configuration, see:
-#   * Official English Documentation: http://nginx.org/en/docs/
-#   * Official Russian Documentation: http://nginx.org/ru/docs/
+user nginx;
+worker_processes 1;
 
-user nginx;
-worker_processes auto;
 error_log /var/log/nginx/error.log;
 pid /run/nginx.pid;
 
@@ -36,7 +33,7 @@
     include /etc/nginx/conf.d/*.conf;
 
     server {
-        listen       80;
+       listen       80;
         listen       [::]:80;
         server_name  _;
         root         /usr/share/nginx/html;
@@ -48,7 +45,7 @@
         location = /404.html {
         }
 
-        error_page 500 502 503 504 /50x.html;
+       error_page 500 502 503 504 /50x.html;
         location = /50x.html {
         }
     }

changed: [lighthouse-01]

RUNNING HANDLER [Start nginx] *************************************************************************************************************************************************************************************************************************************************************************************
changed: [lighthouse-01]

RUNNING HANDLER [Reload nginx] ************************************************************************************************************************************************************************************************************************************************************************************
changed: [lighthouse-01]

PLAY [Install Lighthouse] *****************************************************************************************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ********************************************************************************************************************************************************************************************************************************************************************************************
ok: [lighthouse-01]

TASK [Lighthouse | install git] ***********************************************************************************************************************************************************************************************************************************************************************************
changed: [lighthouse-01]

TASK [Lighthouse | Copy from git] *********************************************************************************************************************************************************************************************************************************************************************************
>> Newly checked out d701335c25cd1bb9b5155711190bad8ab852c2ce
changed: [lighthouse-01]

TASK [Lighthouse | Create lighthouse config] **********************************************************************************************************************************************************************************************************************************************************************
--- before
+++ after: /Users/maksimtomaev/.ansible/tmp/ansible-local-71214oh1ky47i/tmp_vxmae_k/lighthouse.conf.j2
@@ -0,0 +1,11 @@
+server {
+    listen       80;
+    server_name  localhost
+    
+    access_log  /var/log/nginx lighthouse_access.log  main;
+    
+    location / {
+        root   home/netology/lighthouse;
+        index  index.html;
+    }
+}

changed: [lighthouse-01]

RUNNING HANDLER [Reload nginx] ************************************************************************************************************************************************************************************************************************************************************************************
changed: [lighthouse-01]

PLAY RECAP ********************************************************************************************************************************************************************************************************************************************************************************************************
clickhouse-01              : ok=5    changed=4    unreachable=0    failed=0    skipped=0    rescued=1    ignored=0   
lighthouse-01              : ok=11   changed=9    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
vector-01                  : ok=4    changed=3    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
````   

## Задача   
8. Повторно запустите playbook с флагом `--diff` и убедитесь, что playbook идемпотентен.   

## Ответ   
````   
➜  playbook git:(ansible-dz3) ✗ ansible-playbook -i inventory/prod.yml site.yml --diff

PLAY [Install Clickhouse] *****************************************************************************************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ********************************************************************************************************************************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Get clickhouse distrib] *************************************************************************************************************************************************************************************************************************************************************************************
ok: [clickhouse-01] => (item=clickhouse-client)
ok: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "gid": 1000, "group": "netology", "item": "clickhouse-common-static", "mode": "0644", "msg": "Request failed", "owner": "netology", "response": "HTTP Error 404: Not Found", "secontext": "unconfined_u:object_r:user_home_t:s0", "size": 246310036, "state": "file", "status_code": 404, "uid": 1000, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get rescue clickhouse distrib] ******************************************************************************************************************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Install clickhouse packages] ********************************************************************************************************************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Flush handlers] *********************************************************************************************************************************************************************************************************************************************************************************************

TASK [Create database] ********************************************************************************************************************************************************************************************************************************************************************************************
ok: [clickhouse-01]

PLAY [Install Vector] *********************************************************************************************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ********************************************************************************************************************************************************************************************************************************************************************************************
ok: [vector-01]

TASK [Get vector distrib] *****************************************************************************************************************************************************************************************************************************************************************************************
ok: [vector-01]

TASK [Install vector packages] ************************************************************************************************************************************************************************************************************************************************************************************
ok: [vector-01]

TASK [Flush handlers] *********************************************************************************************************************************************************************************************************************************************************************************************

PLAY [Install nginx] **********************************************************************************************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ********************************************************************************************************************************************************************************************************************************************************************************************
ok: [lighthouse-01]

TASK [NGINX | Install epel-release] *******************************************************************************************************************************************************************************************************************************************************************************
ok: [lighthouse-01]

TASK [NGINX | Install nginx] **************************************************************************************************************************************************************************************************************************************************************************************
ok: [lighthouse-01]

TASK [NGINX | Create general config] ******************************************************************************************************************************************************************************************************************************************************************************
ok: [lighthouse-01]

PLAY [Install Lighthouse] *****************************************************************************************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ********************************************************************************************************************************************************************************************************************************************************************************************
ok: [lighthouse-01]

TASK [Lighthouse | install git] ***********************************************************************************************************************************************************************************************************************************************************************************
ok: [lighthouse-01]

TASK [Lighthouse | Copy from git] *********************************************************************************************************************************************************************************************************************************************************************************
ok: [lighthouse-01]

TASK [Lighthouse | Create lighthouse config] **********************************************************************************************************************************************************************************************************************************************************************
ok: [lighthouse-01]

PLAY RECAP ********************************************************************************************************************************************************************************************************************************************************************************************************
clickhouse-01              : ok=4    changed=0    unreachable=0    failed=0    skipped=0    rescued=1    ignored=0   
lighthouse-01              : ok=8    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
vector-01                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
````   

## Задача   
9. Подготовьте README.md-файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги.   

## Ответ   
[README.md](/playbook/README.md)   

## Задача   
10. Готовый playbook выложите в свой репозиторий, поставьте тег `08-ansible-03-yandex` на фиксирующий коммит, в ответ предоставьте ссылку на него.

## Ответ  
[commit](https://github.com/tomaevmax/devops-netology/commit/02a9e8b36b1d6d80bd2890158c8ec4500e9d48db) 
