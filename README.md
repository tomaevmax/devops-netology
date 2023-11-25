# Домашнее задание к занятию «Helm»

### Задание 1. Подготовить Helm-чарт для приложения

1. Необходимо упаковать приложение в чарт для деплоя в разные окружения. 
2. Каждый компонент приложения деплоится отдельным deployment’ом или statefulset’ом.
3. В переменных чарта измените образ приложения для изменения версии.

<details>
<summary>Ответ</summary>
<br>   

[deployment](/nginx/templates/deployment.yaml)   
[nginx values](/nginx/nginx.yaml)   
[multitool values](/nginx/multitool.yaml)  

</details>

------
### Задание 2. Запустить две версии в разных неймспейсах

1. Подготовив чарт, необходимо его проверить. Запуститe несколько копий приложения.
2. Одну версию в namespace=app1, вторую версию в том же неймспейсе, третью версию в namespace=app2.
3. Продемонстрируйте результат.

<details>
<summary>Ответ</summary>
<br>   

Проверяем манифесты и values   

```   
➜  devops-netology git:(k8s_dz10) ✗ helm lint netology-app -f nginx/nginx.yaml               
==> Linting netology-app
Error unable to check Chart.yaml file in chart: stat netology-app/Chart.yaml: no such file or directory

Error: 1 chart(s) linted, 1 chart(s) failed
➜  devops-netology git:(k8s_dz10) ✗ helm lint netology-app -f nginx/multitool.yaml 
==> Linting netology-app
Error unable to check Chart.yaml file in chart: stat netology-app/Chart.yaml: no such file or directory

Error: 1 chart(s) linted, 1 chart(s) failed

```   
Ставим первую версию в ns app1
````   
➜  nginx git:(k8s_dz10) ✗ cat Chart.yaml | grep appVersion
appVersion: "1.0.0"

➜  devops-netology git:(k8s_dz10) ✗ helm upgrade --install --atomic netology-app-front nginx/ --namespace app1 -f nginx/nginx.yaml
Release "netology-app-front" does not exist. Installing it now.
NAME: netology-app-front
LAST DEPLOYED: Sat Nov 25 08:49:48 2023
NAMESPACE: app1
STATUS: deployed
REVISION: 1
NOTES:
1. Get the application URL by running these commands:
  export POD_NAME=$(kubectl get pods --namespace app1 -l "app.kubernetes.io/name=netology-app,app.kubernetes.io/instance=netology-app-front" -o jsonpath="{.items[0].metadata.name}")
  export CONTAINER_PORT=$(kubectl get pod --namespace app1 $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")
  echo "Visit http://127.0.0.1:8080 to use your application"
  kubectl --namespace app1 port-forward $POD_NAME 8080:$CONTAINER_PORT
➜  devops-netology git:(k8s_dz10) ✗ helm upgrade --install --atomic netology-app-back nginx/ --namespace app1 -f nginx/multitool.yaml
Release "netology-app-back" has been upgraded. Happy Helming!
NAME: netology-app-back
LAST DEPLOYED: Sat Nov 25 08:50:13 2023
NAMESPACE: app1
STATUS: deployed
REVISION: 2
NOTES:
1. Get the application URL by running these commands:
  export POD_NAME=$(kubectl get pods --namespace app1 -l "app.kubernetes.io/name=netology-app,app.kubernetes.io/instance=netology-app-back" -o jsonpath="{.items[0].metadata.name}")
  export CONTAINER_PORT=$(kubectl get pod --namespace app1 $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")
  echo "Visit http://127.0.0.1:8080 to use your application"
  kubectl --namespace app1 port-forward $POD_NAME 8080:$CONTAINER_PORT
➜  devops-netology git:(k8s_dz10) ✗ kubectl -n app1 get pods                                                                     
NAME                     READY   STATUS    RESTARTS   AGE
nginx-5994654c77-5b6zb   1/1     Running   0          33s
multitool-0              1/1     Running   0          8s

````   
Обновляем версию приложения до 1.1.0

````  
➜  devops-netology git:(k8s_dz10) ✗ cat nginx/Chart.yaml | grep appVersion
appVersion: "1.1.0"
➜  devops-netology git:(k8s_dz10) ✗ helm upgrade --install --atomic netology-app-back nginx/ --namespace app1 -f nginx/multitool.yaml
Release "netology-app-back" has been upgraded. Happy Helming!
NAME: netology-app-back
LAST DEPLOYED: Sat Nov 25 09:09:36 2023
NAMESPACE: app1
STATUS: deployed
REVISION: 4
➜  devops-netology git:(k8s_dz10) ✗ helm upgrade --install --atomic netology-app-front nginx/ --namespace app1 -f nginx/nginx.yaml   
Release "netology-app-front" has been upgraded. Happy Helming!
NAME: netology-app-front
LAST DEPLOYED: Sat Nov 25 09:09:42 2023
NAMESPACE: app1
STATUS: deployed
REVISION: 3
➜  devops-netology git:(k8s_dz10) ✗ kubectl -n app1 get pods
NAME                     READY   STATUS    RESTARTS   AGE
nginx-5994654c77-9278j   1/1     Running   0          60s
multitool-0              1/1     Running   0          44s

````   
Ставим третью версию в ns app2

````   
➜  devops-netology git:(k8s_dz10) ✗ cat nginx/Chart.yaml | grep appVersion
appVersion: "1.1.2"
➜  devops-netology git:(k8s_dz10) ✗ helm upgrade --install --atomic netology-app-front nginx/ --namespace app2 -f nginx/nginx.yaml
Release "netology-app-front" does not exist. Installing it now.
NAME: netology-app-front
LAST DEPLOYED: Sat Nov 25 09:13:25 2023
NAMESPACE: app2
STATUS: deployed
REVISION: 1
➜  devops-netology git:(k8s_dz10) ✗ helm upgrade --install --atomic netology-app-back nginx/ --namespace app2 -f nginx/multitool.yaml
Release "netology-app-back" does not exist. Installing it now.
NAME: netology-app-back
LAST DEPLOYED: Sat Nov 25 09:13:42 2023
NAMESPACE: app2
STATUS: deployed
REVISION: 1
➜  devops-netology git:(k8s_dz10) ✗ kubectl -n app2 get pods                                                                  
NAME                     READY   STATUS    RESTARTS   AGE
nginx-5994654c77-gkvcg   1/1     Running   0          26s
multitool-0              1/1     Running   0          9s

````   

</details>


















# Домашнее задание к занятию «Управление доступом»

### Задание 1. Создайте конфигурацию для подключения пользователя

1. Создайте и подпишите SSL-сертификат для подключения к кластеру.
2. Настройте конфигурационный файл kubectl для подключения.
3. Создайте роли и все необходимые настройки для пользователя.
4. Предусмотрите права пользователя. Пользователь может просматривать логи подов и их конфигурацию (`kubectl logs pod <pod_id>`, `kubectl describe pod <pod_id>`).
5. Предоставьте манифесты и скриншоты и/или вывод необходимых команд.

<details>
<summary>Ответ</summary>
<br>   

[role](/role.yaml)   
[rolebinding](/rolebinding.yaml)   


Создаем SSL-сертификат
````    
netology@microk8s:~/k8s$ openssl genrsa -out test.key 2048
netology@microk8s:~/k8s$openssl req -new -key test.key -out test.csr -subj "/CN=test/O=ops"
netology@microk8s:~/k8s$sudo openssl x509 -req -in test.csr -CA /var/snap/microk8s/current/certs/ca.crt -CAkey /var/snap/microk8s/current/certs/ca.key -out test.crt -days 365  
netology@microk8s:~/k8s$ ls
test.crt  test.csr  test.key

````
Настраиваем конфигурационный файл kubectl

````   
netology@microk8s:~/k8s$ kubectl config set-credentials test --client-certificate=test.crt --client-key=test.key --embed-certs=true
User "test" set.

netology@microk8s:~/k8s$ kubectl config set-context test --cluster=microk8s-cluster --user=test
Context "test" created.

netology@microk8s:~/k8s$ kubectl config get-contexts 
CURRENT   NAME       CLUSTER            AUTHINFO   NAMESPACE
*         microk8s   microk8s-cluster   admin      
          test       microk8s-cluster   test       

netology@microk8s:~/k8s$ kubectl config use-context test
Switched to context "test".

netology@microk8s:~/k8s$ kubectl config get-contexts 
CURRENT   NAME       CLUSTER            AUTHINFO   NAMESPACE
          microk8s   microk8s-cluster   admin      
*         test       microk8s-cluster   test       

````   
Создаем роли и необходимые настройки   

~~~
netology@microk8s:~/k8s$ kubectl create ns test
namespace/test created
netology@microk8s:~/k8s$ kubectl -n test create -f role.yaml
role.rbac.authorization.k8s.io/logs-config-reader created
netology@microk8s:~/k8s$ kubectl -n test get role
NAME                 CREATED AT
logs-config-reader   2023-11-21T05:38:23Z
netology@microk8s:~/k8s$ kubectl -n test create -f roleb.yaml 
rolebinding.rbac.authorization.k8s.io/logs-config-reader created
netology@microk8s:~/k8s$ kubectl -n test get rolebindings  
NAME                 ROLE                      AGE
logs-config-reader   Role/logs-config-reader   12s

netology@microk8s:~/k8s$ kubectl -n test get pods
NAME                     READY   STATUS    RESTARTS   AGE
nginx-7854ff8877-q59bs   1/1     Running   0          5m37s
netology@microk8s:~/k8s$ kubectl -n test get logs nginx-7854ff8877-q59bs
error: the server doesn't have a resource type "logs"
netology@microk8s:~/k8s$ kubectl -n test logs nginx-7854ff8877-q59bs
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: info: Enabled listen on IPv6 in /etc/nginx/conf.d/default.conf
/docker-entrypoint.sh: Sourcing /docker-entrypoint.d/15-local-resolvers.envsh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2023/11/21 05:41:42 [notice] 1#1: using the "epoll" event method
2023/11/21 05:41:42 [notice] 1#1: nginx/1.25.3
2023/11/21 05:41:42 [notice] 1#1: built by gcc 12.2.0 (Debian 12.2.0-14) 
2023/11/21 05:41:42 [notice] 1#1: OS: Linux 5.15.0-88-generic
2023/11/21 05:41:42 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 65536:65536
2023/11/21 05:41:42 [notice] 1#1: start worker processes
2023/11/21 05:41:42 [notice] 1#1: start worker process 30
2023/11/21 05:41:42 [notice] 1#1: start worker process 31
2023/11/21 05:41:42 [notice] 1#1: start worker process 32
2023/11/21 05:41:42 [notice] 1#1: start worker process 33

   
~~~   



</details>   
