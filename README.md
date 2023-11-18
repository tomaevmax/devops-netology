# Домашнее задание к занятию «Конфигурация приложений»

 
### Задание 1. Создать Deployment приложения и решить возникшую проблему с помощью ConfigMap. Добавить веб-страницу

1. Создать Deployment приложения, состоящего из контейнеров nginx и multitool.
2. Решить возникшую проблему с помощью ConfigMap.
3. Продемонстрировать, что pod стартовал и оба конейнера работают.
4. Сделать простую веб-страницу и подключить её к Nginx с помощью ConfigMap. Подключить Service и показать вывод curl или в браузере.
5. Предоставить манифесты, а также скриншоты или вывод необходимых команд.

<details>
<summary>Ответ</summary>
<br>   

[deployment_confimap](/deployment_confimap.yaml)   
[configmap](/configmap.yaml)   
[configmap_nginx](/configmap_nginx.yaml)   
[service](/service.yaml)  

````  
netology@microk8s:~/k8s$ kubectl get pods
NAME                      READY   STATUS    RESTARTS   AGE
custom-86f46b4758-g546t   2/2     Running   0          6m20s

netology@microk8s:~/k8s$ kubectl describe pods custom-86f46b4758-g546t
Name:             custom-86f46b4758-g546t
Namespace:        default
Priority:         0
Service Account:  default
Node:             microk8s/10.129.0.8
Start Time:       Sat, 18 Nov 2023 04:45:08 +0000
Labels:           app=nginx
                  pod-template-hash=86f46b4758
Annotations:      cni.projectcalico.org/containerID: 39563fcd730ec40ff9773d642971faf3d37cee9a126c8c12349aa8ce705a8fa7
                  cni.projectcalico.org/podIP: 10.1.128.200/32
                  cni.projectcalico.org/podIPs: 10.1.128.200/32
Status:           Running
IP:               10.1.128.200
IPs:
  IP:           10.1.128.200
Controlled By:  ReplicaSet/custom-86f46b4758
Containers:
  nginx:
    Container ID:   containerd://039ba9adca7c00903509c7f27ecb52b2f31454a0b3ae51fc5b99e696668ace2e
    Image:          nginx:1.14.2
    Image ID:       docker.io/library/nginx@sha256:f7988fb6c02e0ce69257d9bd9cf37ae20a60f1df7563c3a2a6abe24160306b8d
    Port:           80/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Sat, 18 Nov 2023 04:45:09 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /usr/share/nginx/html from content (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-98dw7 (ro)
  multitool:
    Container ID:   containerd://e3a41952a6c49624e711cda0743d5bbecaa46bd636f0d88b1e9958bda20d18ec
    Image:          wbitt/network-multitool
    Image ID:       docker.io/wbitt/network-multitool@sha256:d1137e87af76ee15cd0b3d4c7e2fcd111ffbd510ccd0af076fc98dddfc50a735
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Sat, 18 Nov 2023 04:45:11 +0000
    Ready:          True
    Restart Count:  0
    Environment:
      HTTP_PORT:   <set to the key 'http_port' of config map 'multitool-port'>   Optional: false
      HTTPS_PORT:  <set to the key 'https_port' of config map 'multitool-port'>  Optional: false
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-98dw7 (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  content:
    Type:      ConfigMap (a volume populated by a ConfigMap)
    Name:      nginx-content
    Optional:  false
  kube-api-access-98dw7:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:                      <none>
netology@microk8s:~/k8s$ 



````   

Вызов тестовой страницы   

````   
netology@microk8s:~$ curl -v localhost:8080
*   Trying 127.0.0.1:8080...
* Connected to localhost (127.0.0.1) port 8080 (#0)
> GET / HTTP/1.1
> Host: localhost:8080
> User-Agent: curl/7.81.0
> Accept: */*
> 
* Mark bundle as not supporting multiuse
< HTTP/1.1 200 OK
< Server: nginx/1.14.2
< Date: Sat, 18 Nov 2023 04:49:27 GMT
< Content-Type: text/html
< Content-Length: 68
< Last-Modified: Sat, 18 Nov 2023 04:45:08 GMT
< Connection: keep-alive
< ETag: "65584154-44"
< Accept-Ranges: bytes
< 
<!DOCTYPE html>
<html>
<body>
<h1>Hello World!</h1>
</body>
</html>
* Connection #0 to host localhost left intact


````

</details>   


------

### Задание 2. Создать приложение с вашей веб-страницей, доступной по HTTPS 

1. Создать Deployment приложения, состоящего из Nginx.
2. Создать собственную веб-страницу и подключить её как ConfigMap к приложению.
3. Выпустить самоподписной сертификат SSL. Создать Secret для использования сертификата.
4. Создать Ingress и необходимый Service, подключить к нему SSL в вид. Продемонстировать доступ к приложению по HTTPS. 
4. Предоставить манифесты, а также скриншоты или вывод необходимых команд.


<details>
<summary>Ответ</summary>
<br>   

[deployment_nginx](/deployment_nginx.yaml)   
[sercret](/sercret..yaml)   
[service_nginx](/service_nginx.yaml)   
[ingress](/ingress.yaml)  
Configmap используем тот же
[configmap_nginx](/configmap_nginx.yaml)

````  
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -addext "subjectAltName = IP:158.160.23.204" -keyout /etc/ssl/private/key.key -out /etc/ssl/certs/cer.crt

netology@microk8s:~/k8s$ kubectl describe ingress
Name:             test-tls
Labels:           <none>
Namespace:        default
Address:          
Ingress Class:    nginx
Default backend:  <default>
TLS:
  nginx-tls terminates test-tls.com
Rules:
  Host          Path  Backends
  ----          ----  --------
  test-tls.com  
                /   service-nginx-web:80 (10.1.128.202:80)
Annotations:    nginx.ingress.kubernetes.io/rewrite-target: /
Events:
  Type    Reason  Age   From                      Message
  ----    ------  ----  ----                      -------
  Normal  Sync    12s   nginx-ingress-controller  Scheduled for sync

netology@microk8s:/etc$ curl -k --resolve test-tls.com:443:158.160.23.204 https://test-tls.com/
<!DOCTYPE html>
<html>
<body>
<h1>Hello World!</h1>
</body>
</html>


````

</details>   


------

