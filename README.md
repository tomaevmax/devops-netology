# Домашнее задание к занятию «Как работает сеть в K8s»


### Задание 1. Создать сетевую политику или несколько политик для обеспечения доступа

1. Создать deployment'ы приложений frontend, backend и cache и соответсвующие сервисы.
2. В качестве образа использовать network-multitool.
3. Разместить поды в namespace App.
4. Создать политики, чтобы обеспечить доступ frontend -> backend -> cache. Другие виды подключений должны быть запрещены.
5. Продемонстрировать, что трафик разрешён и запрещён.

<details>
<summary>Ответ</summary>
<br>   

Деплойменты    
[deployment](/nginx/templates/deployment.yaml)   
[service](/nginx/templates/service.yaml)   

Политики    
[network_policy_back_to_cache values](nginx/network_policy_back_to_cache.yaml)   
[network_policy_deny_all values](nginx/network_policy_deny_all.yaml)    
[network_policy_front_to_back values](nginx/network_policy_front_to_back.yaml)    

````   
➜  devops-netology git:(k8s_dz13) ✗ helm upgrade --install --atomic netology-app-front nginx --namespace app -f nginx/backend.yaml      
➜  devops-netology git:(k8s_dz13) ✗ helm upgrade --install --atomic netology-app-back nginx --namespace app -f nginx/frontend.yaml 
➜  devops-netology git:(k8s_dz13) ✗ helm upgrade --install --atomic netology-app-cashe nginx --namespace app -f nginx/cache.yaml   

➜  devops-netology git:(k8s_dz13) ✗ kubectl -n app get pods                                                                       
NAME                        READY   STATUS    RESTARTS   AGE
backend-5497d79fc-4s7jw     1/1     Running   0          85s
frontend-6967d4f989-gp2sx   1/1     Running   0          33s
cashe-65475b698c-2jdcl      1/1     Running   0          7s

➜  devops-netology git:(k8s_dz13) ✗ kubectl apply -n app -f nginx/network_policy_back_to_cache.yaml
networkpolicy.networking.k8s.io/allow-back-to-cache created
➜  devops-netology git:(k8s_dz13) ✗ kubectl apply -n app -f nginx/network_policy_deny_all.yaml 
networkpolicy.networking.k8s.io/ingress-deny-all created
➜  devops-netology git:(k8s_dz13) ✗ kubectl apply -n app -f nginx/network_policy_front_to_back.yaml
networkpolicy.networking.k8s.io/allow-front-to-back created
➜  devops-netology git:(k8s_dz13) ✗ kubectl get networkpolicy                                  
No resources found in default namespace.
➜  devops-netology git:(k8s_dz13) ✗ kubectl get -n app networkpolicy
NAME                  POD-SELECTOR   AGE
allow-back-to-cache   app=cache      44s
ingress-deny-all      <none>         28s
allow-front-to-back   app=backend    11s

➜  devops-netology git:(k8s_dz13) ✗ kubectl exec -n app -it frontend-6967d4f989-gp2sx -- sh
/ # curl -v backend
* processing: backend
*   Trying 10.152.183.144:80...
* Connected to backend (10.152.183.144) port 80
> GET / HTTP/1.1
> Host: backend
> User-Agent: curl/8.2.1
> Accept: */*
> 
< HTTP/1.1 200 OK
< Server: nginx/1.24.0
< Date: Tue, 05 Dec 2023 23:41:36 GMT
< Content-Type: text/html
< Content-Length: 140
< Last-Modified: Tue, 05 Dec 2023 23:29:05 GMT
< Connection: keep-alive
< ETag: "656fb241-8c"
< Accept-Ranges: bytes
< 
WBITT Network MultiTool (with NGINX) - backend-5497d79fc-4s7jw - 10.1.254.110 - HTTP: 80 , HTTPS: 443 . (Formerly praqma/network-multitool)
* Connection #0 to host backend left intact

➜  devops-netology git:(k8s_dz13) ✗ kubectl exec -n app -it cashe-65475b698c-2jdcl -- sh   
/ # curl -v frontend
* processing: frontend
*   Trying 10.152.183.134:80...
* connect to 10.152.183.134 port 80 failed: Operation timed out
* Failed to connect to frontend port 80 after 130462 ms: Couldn't connect to server
* Closing connection
curl: (28) Failed to connect to frontend port 80 after 130462 ms: Couldn't connect to server


````

</details>