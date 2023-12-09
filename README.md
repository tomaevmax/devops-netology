# Домашнее задание к занятию Troubleshooting

### Задание. При деплое приложение web-consumer не может подключиться к auth-db. Необходимо это исправить

1. Установить приложение по команде:
```shell
kubectl apply -f https://raw.githubusercontent.com/netology-code/kuber-homeworks/main/3.5/files/task.yaml
```
2. Выявить проблему и описать.
3. Исправить проблему, описать, что сделано.
4. Продемонстрировать, что проблема решена.


<details>
<summary>Ответ</summary>
<br>   
Пробуем установить    

````  
netology@k8s:~$ kubectl apply -f https://raw.githubusercontent.com/netology-code/kuber-homeworks/main/3.5/files/task.yaml
Error from server (NotFound): error when creating "https://raw.githubusercontent.com/netology-code/kuber-homeworks/main/3.5/files/task.yaml": namespaces "web" not found
Error from server (NotFound): error when creating "https://raw.githubusercontent.com/netology-code/kuber-homeworks/main/3.5/files/task.yaml": namespaces "data" not found
Error from server (NotFound): error when creating "https://raw.githubusercontent.com/netology-code/kuber-homeworks/main/3.5/files/task.yaml": namespaces "data" not found

````    
Согласно логу ошибка из-за отсутствия в кластере наймспейсов web и data

Создаем наймспейсы и пытаемся еще раз установить.
````
netology@k8s:~$ kubectl create ns web
namespace/web created
netology@k8s:~$ kubectl create ns data
namespace/data created
netology@k8s:~$ kubectl apply -f https://raw.githubusercontent.com/netology-code/kuber-homeworks/main/3.5/files/task.yaml
deployment.apps/web-consumer created
deployment.apps/auth-db created
service/auth-db created

netology@k8s:~$ kubectl get -n data pods
NAME                       READY   STATUS    RESTARTS   AGE
auth-db-7b5cdbdc77-jtbql   1/1     Running   0          39s
netology@k8s:~$ kubectl get -n web  pods
NAME                            READY   STATUS    RESTARTS   AGE
web-consumer-5f87765478-c6bjn   1/1     Running   0          44s
web-consumer-5f87765478-6txx6   1/1     Running   0          44s

````   
Смотри лог пода web
````   
netology@k8s:~$ kubectl logs -n web web-consumer-5f87765478-c6bjn
curl: (6) Couldn't resolve host 'auth-db'

````   
Причина ошибки неверный URL при вызове команды curl, так как под auth-db находится в другом неймспейсе,
то обращение должно идти по полному FQDN

Правим деплоймент, ждем пересоздания подов 

````   
netology@k8s:~$ kubectl edit -n web deployment web-consumer
deployment.apps/web-consumer edited
netology@k8s:~$ kubectl get -n web  pods
NAME                            READY   STATUS        RESTARTS   AGE
web-consumer-76669b5d6d-cn8md   1/1     Running       0          4s
web-consumer-5f87765478-c6bjn   1/1     Terminating   0          4m52s
web-consumer-76669b5d6d-csgqp   1/1     Running       0          3s
web-consumer-5f87765478-6txx6   1/1     Terminating   0          4m52s

````   
Смотри лог пода web
````   
netology@k8s:~$ kubectl logs -n web web-consumer-76669b5d6d-cn8md
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
<!DOCTYPE html>
100   612  100   612    0     0   3757      0 --:--:-- --:--:-- --:--:--  597k
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
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   612  100   612    0     0   362k      0 --:--:-- --:--:-- --:--:--  597k

````   
Ошибка устранена, подключение восстановлено.

</details>