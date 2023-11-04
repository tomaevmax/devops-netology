# Домашнее задание к занятию «Сетевое взаимодействие в K8S. Часть 2»

### Задание 1. Создать Deployment приложений backend и frontend

1. Создать Deployment приложения _frontend_ из образа nginx с количеством реплик 3 шт.
2. Создать Deployment приложения _backend_ из образа multitool. 
3. Добавить Service, которые обеспечат доступ к обоим приложениям внутри кластера. 
4. Продемонстрировать, что приложения видят друг друга с помощью Service.
5. Предоставить манифесты Deployment и Service в решении, а также скриншоты или вывод команды п.4.

<details>
<summary>Ответ</summary>
<br>   

[deployment_backend](/deployment_backend.yaml)   
[deployment_frontend](/deployment_frontend.yaml)   
[service_frontend](/service_frontend.yaml)   
[service_backend](/service_backend.yaml)   

````  
netology@mickrok8s:~$ kubectl get -n ingress  pods
NAME                                      READY   STATUS    RESTARTS   AGE
backend-6c8867d7fc-pghf9                  1/1     Running   0          18m
frontend-cbdccf466-mdzzq                  1/1     Running   0          17m
frontend-cbdccf466-fr4ql                  1/1     Running   0          17m
frontend-cbdccf466-k9h88                  1/1     Running   0          17m

````   
В поде с образом nginx не установлен curl , проверям с пода с multitool
````
netology@mickrok8s:~$ kubectl exec -n ingress frontend-cbdccf466-mdzzq -it /bin/sh
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
# curl  
/bin/sh: 1: curl: not found

netology@mickrok8s:~$ kubectl exec -n ingress backend-6c8867d7fc-pghf9 -it /bin/sh
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
/ # curl frontend
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>

````   
Проверям оба сервиса с временного пода   

````
netology@mickrok8s:~$ kubectl run mycurlpod --image=wbitt/network-multitool -i --tty --rm -- sh
If you don't see a command prompt, try pressing enter.
/ # curl frontend
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
/ # curl backend
WBITT Network MultiTool (with NGINX) - backend-6c8867d7fc-h9bdz - 10.1.233.8 - HTTP: 80 , HTTPS: 443 . (Formerly praqma/network-multitool)

````   

</details>   

------

### Задание 2. Создать Ingress и обеспечить доступ к приложениям снаружи кластера

1. Включить Ingress-controller в MicroK8S.
2. Создать Ingress, обеспечивающий доступ снаружи по IP-адресу кластера MicroK8S так, чтобы при запросе только по адресу открывался _frontend_ а при добавлении /api - _backend_.
3. Продемонстрировать доступ с помощью браузера или `curl` с локального компьютера.
4. Предоставить манифесты и скриншоты или вывод команды п.2.

<details>
<summary>Ответ</summary>
<br>   

[ingress](/ingress.yaml)   

Включаем ingress в MicroK8s
````  
netology@mickrok8s:~$ sudo microk8s enable ingress
Infer repository core for addon ingress
Enabling Ingress
ingressclass.networking.k8s.io/public created
ingressclass.networking.k8s.io/nginx created
namespace/ingress created
serviceaccount/nginx-ingress-microk8s-serviceaccount created
clusterrole.rbac.authorization.k8s.io/nginx-ingress-microk8s-clusterrole created
role.rbac.authorization.k8s.io/nginx-ingress-microk8s-role created
clusterrolebinding.rbac.authorization.k8s.io/nginx-ingress-microk8s created
rolebinding.rbac.authorization.k8s.io/nginx-ingress-microk8s created
configmap/nginx-load-balancer-microk8s-conf created
configmap/nginx-ingress-tcp-microk8s-conf created
configmap/nginx-ingress-udp-microk8s-conf created
daemonset.apps/nginx-ingress-microk8s-controller created
Ingress is enabled


````   
Проверяем доступ с помощью curl с локального ПК   

````   
➜  devops-netology git:(k8s_dz5) ✗ curl 130.193.53.216/api
WBITT Network MultiTool (with NGINX) - backend-6c8867d7fc-pghf9 - 10.1.233.12 - HTTP: 80 , HTTPS: 443 . (Formerly praqma/network-multitool)
➜  devops-netology git:(k8s_dz5) ✗ curl 130.193.53.216    
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>

````   

</details>   

------   