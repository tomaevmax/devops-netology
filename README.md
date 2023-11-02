# Домашнее задание к занятию «Сетевое взаимодействие в K8S. Часть 1»

### Задание 1. Создать Deployment и обеспечить доступ к контейнерам приложения по разным портам из другого Pod внутри кластера

1. Создать Deployment приложения, состоящего из двух контейнеров (nginx и multitool), с количеством реплик 3 шт.
2. Создать Service, который обеспечит доступ внутри кластера до контейнеров приложения из п.1 по порту 9001 — nginx 80, по 9002 — multitool 8080.
3. Создать отдельный Pod с приложением multitool и убедиться с помощью `curl`, что из пода есть доступ до приложения из п.1 по разным портам в разные контейнеры.
4. Продемонстрировать доступ с помощью `curl` по доменному имени сервиса.
5. Предоставить манифесты Deployment и Service в решении, а также скриншоты или вывод команды п.4.

<details>
<summary>Ответ</summary>
<br>   

[deployment](/deployment.yaml)   
[service](/service.yaml)   

````
netology@microk8s:~/k8s$ kubectl run mycurlpod --image=wbitt/network-multitool -i --tty --rm -- sh
If you don't see a command prompt, try pressing enter.
/ # curl -v nginx-service:9001
* processing: nginx-service:9001
*   Trying 10.152.183.208:9001...
* Connected to nginx-service (10.152.183.208) port 9001
> GET / HTTP/1.1
> Host: nginx-service:9001
> User-Agent: curl/8.2.1
> Accept: */*
> 
< HTTP/1.1 200 OK
< Server: nginx/1.14.2
< Date: Thu, 02 Nov 2023 03:48:43 GMT
< Content-Type: text/html
< Content-Length: 612
< Last-Modified: Tue, 04 Dec 2018 14:44:49 GMT
< Connection: keep-alive
< ETag: "5c0692e1-264"
< Accept-Ranges: bytes
< 
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
* Connection #0 to host nginx-service left intact
/ # curl -v nginx-service:9002
* processing: nginx-service:9002
*   Trying 10.152.183.208:9002...
* Connected to nginx-service (10.152.183.208) port 9002
> GET / HTTP/1.1
> Host: nginx-service:9002
> User-Agent: curl/8.2.1
> Accept: */*
> 
< HTTP/1.1 200 OK
< Server: nginx/1.24.0
< Date: Thu, 02 Nov 2023 03:49:01 GMT
< Content-Type: text/html
< Content-Length: 154
< Last-Modified: Thu, 02 Nov 2023 03:45:06 GMT
< Connection: keep-alive
< ETag: "65431b42-9a"
< Accept-Ranges: bytes
< 
WBITT Network MultiTool (with NGINX) - nginx-deployment-86b589886b-4xqxx - 10.1.128.199 - HTTP: 8080 , HTTPS: 11443 . (Formerly praqma/network-multitool)
* Connection #0 to host nginx-service left intact

````   

</details>  


------

### Задание 2. Создать Service и обеспечить доступ к приложениям снаружи кластера

1. Создать отдельный Service приложения из Задания 1 с возможностью доступа снаружи кластера к nginx, используя тип NodePort.   
2. Продемонстрировать доступ с помощью браузера или `curl` с локального компьютера.   
3. Предоставить манифест и Service в решении, а также скриншоты или вывод команды п.2.   

<details>
<summary>Ответ</summary>
<br>   

[service_node](/service_node.yaml)   

````  
devops-netology git:(k8s_dz4) ✗ curl -v 158.160.3.88:30080
*   Trying 158.160.3.88:30080...
* Connected to 158.160.3.88 (158.160.3.88) port 30080 (#0)
> GET / HTTP/1.1
> Host: 158.160.3.88:30080
> User-Agent: curl/8.1.2
> Accept: */*
> 
< HTTP/1.1 200 OK
< Server: nginx/1.14.2
< Date: Thu, 02 Nov 2023 03:53:00 GMT
< Content-Type: text/html
< Content-Length: 612
< Last-Modified: Tue, 04 Dec 2018 14:44:49 GMT
< Connection: keep-alive
< ETag: "5c0692e1-264"
< Accept-Ranges: bytes
< 
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
* Connection #0 to host 158.160.3.88 left intact

````   

</details> 

------
