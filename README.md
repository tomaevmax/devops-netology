# Домашнее задание к занятию «Запуск приложений в K8S»

### Задание 1. Создать Deployment и обеспечить доступ к репликам приложения из другого Pod

1. Создать Deployment приложения, состоящего из двух контейнеров — nginx и multitool. Решить возникшую ошибку.
2. После запуска увеличить количество реплик работающего приложения до 2.
<details>
<summary>Ответ</summary>
<br>   

[deployment](/deployment.yaml)

</details>   

3. Продемонстрировать количество подов до и после масштабирования.   
<details>
<summary>Ответ</summary>
<br>

````   
netology@microk8s:~/k8s$ kubectl get pods
NAME                                READY   STATUS    RESTARTS   AGE
nginx-deployment-6b7c9d4fc6-m5s5p   2/2     Running   0          2m13s
netology@microk8s:~/k8s$ vim deployment.yaml 
netology@microk8s:~/k8s$ kubectl apply -f deployment.yaml 
deployment.apps/nginx-deployment configured
netology@microk8s:~/k8s$ kubectl get pods
NAME                                READY   STATUS    RESTARTS   AGE
nginx-deployment-6b7c9d4fc6-m5s5p   2/2     Running   0          2m45s
nginx-deployment-6b7c9d4fc6-sprlk   2/2     Running   0          4s

````   

</details>   

4. Создать Service, который обеспечит доступ до реплик приложений из п.1.   
<details>
<summary>Ответ</summary>
<br>

[service](/service.yaml)  

````   
netology@microk8s:~/k8s$ kubectl get svc
NAME               TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)           AGE
kubernetes         ClusterIP   10.152.183.1     <none>        443/TCP           22m
nginx-deployment   ClusterIP   10.152.183.228   <none>        80/TCP,1180/TCP   49s
````   

</details>  

5. Создать отдельный Pod с приложением multitool и убедиться с помощью `curl`, что из пода есть доступ до приложений из п.1.   
<details>
<summary>Ответ</summary>
<br>

````   
netology@microk8s:~/k8s$ kubectl run mycurlpod --image=curlimages/curl -i --tty --rm -- sh
If you don't see a command prompt, try pressing enter.
~ $ curl nginx-deployment:80 -I
HTTP/1.1 200 OK
Server: nginx/1.14.2
Date: Wed, 01 Nov 2023 04:14:07 GMT
Content-Type: text/html
Content-Length: 612
Last-Modified: Tue, 04 Dec 2018 14:44:49 GMT
Connection: keep-alive
ETag: "5c0692e1-264"
Accept-Ranges: bytes

~ $ curl nginx-deployment:1180 -I
HTTP/1.1 200 OK
Server: nginx/1.24.0
Date: Wed, 01 Nov 2023 04:14:15 GMT
Content-Type: text/html
Content-Length: 154
Last-Modified: Wed, 01 Nov 2023 04:06:10 GMT
Connection: keep-alive
ETag: "6541ceb2-9a"
Accept-Ranges: bytes

````   
</details>  

------

### Задание 2. Создать Deployment и обеспечить старт основного контейнера при выполнении условий

1. Создать Deployment приложения nginx и обеспечить старт контейнера только после того, как будет запущен сервис этого приложения.
<details>
<summary>Ответ</summary>
<br>

[deployment_init](/deployment_init.yaml)  

</details>   

2. Убедиться, что nginx не стартует. В качестве Init-контейнера взять busybox.   
<details>
<summary>Ответ</summary>
<br>

````   
netology@microk8s:~/k8s$ kubectl -n netology get pods
NAME                          READY   STATUS     RESTARTS   AGE
nginx-init-6b9c967fdc-fxw4g   0/1     Init:0/1   0          13s

````   

</details>  

3. Создать и запустить Service. Убедиться, что Init запустился.   
<details>
<summary>Ответ</summary>
<br>

[service_init](/service_init.yaml)  
````   
netology@microk8s:~/k8s$ kubectl -n netology apply -f service_init.yaml 
service/nginx-init created

````   

</details>  

4. Продемонстрировать состояние пода до и после запуска сервиса.   
<details>
<summary>Ответ</summary>
<br>

````   
netology@microk8s:~/k8s$ kubectl -n netology create -f deployment_init.yaml 
deployment.apps/nginx-init created
netology@microk8s:~/k8s$ kubectl -n netology get pods
NAME                          READY   STATUS     RESTARTS   AGE
nginx-init-6b9c967fdc-fxw4g   0/1     Init:0/1   0          13s
netology@microk8s:~/k8s$ kubectl -n netology apply -f service_init.yaml 
service/nginx-init created
netology@microk8s:~/k8s$ kubectl -n netology get pods
NAME                          READY   STATUS    RESTARTS   AGE
nginx-init-6b9c967fdc-fxw4g   1/1     Running   0          68s

````

</details>  


------
