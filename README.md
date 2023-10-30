# Домашнее задание к занятию «Базовые объекты K8S» 

## Задание 1. Создать Pod с именем hello-world

1. Создать манифест (yaml-конфигурацию) Pod.
2. Использовать image - gcr.io/kubernetes-e2e-test-images/echoserver:2.2.

<details>
<summary>Ответ</summary>
<br>

````   
netology@microk8s:~/k8s$ cat pod.yaml 
apiVersion: v1
kind: Pod
metadata:
  name: hello-word
spec:
  containers:
  - name: hello-word
    image: ealen/echo-server:0.8.10
    ports:
    - containerPort: 80
````   
Образ gcr.io/kubernetes-e2e-test-images/echoserver:2.2 не доступен для подключения из вне
вылетает с ошибкой:
 ````   
netology@microk8s:~$ kubectl -n default port-forward pods/hello-word 8080:80 --address 0.0.0.0   
Forwarding from 0.0.0.0:8080 -> 80   
Handling connection for 8080  
E1030 17:30:59.527542    3454 portforward.go:409] an error occurred forwarding 8080 -> 80: error forwarding port 80 to pod 598270c0f71576ee0cca6885167492bd8c6d63990ecc667b0afdd279d67ed04a, uid : failed to execute portforward in network namespace "/var/run/netns/cni-3ad752c2-b924-be3e-1fc6-9947beb6d0e6": failed to connect to localhost:80 inside namespace "598270c0f71576ee0cca6885167492bd8c6d63990ecc667b0afdd279d67ed04a", IPv4: dial tcp4 127.0.0.1:80: connect: connection refused IPv6 dial tcp6 [::1]:80: connect: connection refused 
error: lost connection to pod   

 ````   

</details>    

3. Подключиться локально к Pod с помощью `kubectl port-forward` и вывести значение (curl или в браузере).

<details>
<summary>Ответ</summary>
<br>

````   
netology@microk8s:~/k8s$ kubectl -n default port-forward pods/hello-word 8080:80 --address 0.0.0.0
Forwarding from 0.0.0.0:8080 -> 80
Handling connection for 8080

````   
````   
devops-netology git:(k8s_dz2) ✗ curl 158.160.112.205:8080
{"host":{"hostname":"158.160.112.205","ip":"::ffff:127.0.0.1","ips":[]},"http":{"method":"GET","baseUrl":"","originalUrl":"/","protocol":"http"},"request":{"params":{"0":"/"},"query":{},"cookies":{},"body":{},"headers":{"host":"158.160.112.205:8080","user-agent":"curl/8.1.2","accept":"*/*"}},"environment":{"PATH":"/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin","HOSTNAME":"hello-word","NODE_VERSION":"18.18.2","YARN_VERSION":"1.22.19","KUBERNETES_PORT":"tcp://10.152.183.1:443","KUBERNETES_PORT_443_TCP":"tcp://10.152.183.1:443","KUBERNETES_PORT_443_TCP_PROTO":"tcp","KUBERNETES_PORT_443_TCP_PORT":"443","KUBERNETES_PORT_443_TCP_ADDR":"10.152.183.1","KUBERNETES_SERVICE_HOST":"10.152.183.1","KUBERNETES_SERVICE_PORT":"443","KUBERNETES_SERVICE_PORT_HTTPS":"443","HOME":"/root"}}%
````   

![Снимок экрана 2023-10-30 в 21 05 39](https://github.com/tomaevmax/devops-netology/assets/32243921/d7d01881-7a5e-45c5-ad10-65cba9babd5f)

</details>  

## Задание 2. Создать Service и подключить его к Pod

1. Создать Pod с именем netology-web.
2. Использовать image — gcr.io/kubernetes-e2e-test-images/echoserver:2.2.

<details>
<summary>Ответ</summary>
<br>

````   
netology@microk8s:~/k8s$ cat web.yaml 
apiVersion: v1
kind: Pod
metadata:
  name: netology-web
  labels:
    app: netology-web
spec:
  containers:
  - name: netology-web
    image: ealen/echo-server:0.8.10

````   

</details>   

3. Создать Service с именем netology-svc и подключить к netology-web.

<details>
<summary>Ответ</summary>
<br>

````   
netology@microk8s:~/k8s$ cat svc.yaml 
apiVersion: v1
kind: Service
metadata:
  name: netology-svc
spec:
  selector:
    app: netology-web
  ports:
    - protocol: TCP
      port: 80

````   

</details>   

4. Подключиться локально к Service с помощью `kubectl port-forward` и вывести значение (curl или в браузере).   

<details>
<summary>Ответ</summary>
<br>

````   
netology@microk8s:~/k8s$ kubectl port-forward svc/netology-svc 8888:80 --address 0.0.0.0
Forwarding from 0.0.0.0:8888 -> 80
Handling connection for 8888

````   
````   
 devops-netology git:(k8s_dz2) ✗ curl 158.160.112.205:8888
{"host":{"hostname":"158.160.112.205","ip":"::ffff:127.0.0.1","ips":[]},"http":{"method":"GET","baseUrl":"","originalUrl":"/","protocol":"http"},"request":{"params":{"0":"/"},"query":{},"cookies":{},"body":{},"headers":{"host":"158.160.112.205:8888","user-agent":"curl/8.1.2","accept":"*/*"}},"environment":{"PATH":"/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin","HOSTNAME":"netology-web","NODE_VERSION":"18.18.2","YARN_VERSION":"1.22.19","NETOLOGY_SVC_PORT_80_TCP_ADDR":"10.152.183.240","KUBERNETES_SERVICE_HOST":"10.152.183.1","KUBERNETES_PORT_443_TCP_PROTO":"tcp","KUBERNETES_PORT_443_TCP_ADDR":"10.152.183.1","NETOLOGY_SVC_SERVICE_HOST":"10.152.183.240","NETOLOGY_SVC_PORT_80_TCP_PROTO":"tcp","NETOLOGY_SVC_PORT_80_TCP_PORT":"80","KUBERNETES_SERVICE_PORT_HTTPS":"443","NETOLOGY_SVC_SERVICE_PORT":"80","NETOLOGY_SVC_PORT":"tcp://10.152.183.240:80","KUBERNETES_SERVICE_PORT":"443","KUBERNETES_PORT_443_TCP":"tcp://10.152.183.1:443","NETOLOGY_SVC_PORT_80_TCP":"tcp://10.152.183.240:80","KUBERNETES_PORT":"tcp://10.152.183.1:443","KUBERNETES_PORT_443_TCP_PORT":"443","HOME":"/root"}}%  
````   

![Снимок экрана 2023-10-30 в 21 04 38](https://github.com/tomaevmax/devops-netology/assets/32243921/54178d56-f68e-4436-b2e4-9b4986723cb5)

</details>  

