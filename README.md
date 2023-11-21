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
