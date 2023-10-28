# Домашнее задание к занятию «Kubernetes. Причины появления. Команда kubectl»   

## Задание 1. Установка MicroK8S    

1. Установить MicroK8S на локальную машину или на удалённую виртуальную машину.

<details>
<summary>Ответ</summary>
<br>   
Установку произвел на виртуальную машину, по инструкции из ДЗ.   
  
````   
netology@microk8s:~microk8s status
microk8s is running
high-availability: no
  datastore master nodes: 127.0.0.1:19001
  datastore standby nodes: none
addons:
  enabled:
    dashboard            # (core) The Kubernetes dashboard
    dns                  # (core) CoreDNS
    ha-cluster           # (core) Configure high availability on the current node
    helm                 # (core) Helm - the package manager for Kubernetes
    helm3                # (core) Helm 3 - the package manager for Kubernetes
    metrics-server       # (core) K8s Metrics Server for API access to service metrics
  disabled:
    cert-manager         # (core) Cloud native certificate management
    community            # (core) The community addons repository
    gpu                  # (core) Automatic enablement of Nvidia CUDA
    host-access          # (core) Allow Pods connecting to Host services smoothly
    hostpath-storage     # (core) Storage class; allocates storage from host directory
    ingress              # (core) Ingress controller for external access
    kube-ovn             # (core) An advanced network fabric for Kubernetes
    mayastor             # (core) OpenEBS MayaStor
    metallb              # (core) Loadbalancer for your Kubernetes cluster
    minio                # (core) MinIO object storage
    observability        # (core) A lightweight observability stack for logs, traces and metrics
    prometheus           # (core) Prometheus operator for monitoring and logging
    rbac                 # (core) Role-Based Access Control for authorisation
    registry             # (core) Private image registry exposed on localhost:32000
    storage              # (core) Alias to hostpath-storage add-on, deprecated

````   

</details>   

2. Установить dashboard.

<details>
<summary>Ответ</summary>
<br>

Установку выполняем с помощью команды sudo microk8s enable dashboard   

</details>  

3. Сгенерировать сертификат для подключения к внешнему ip-адресу.   

<details>
<summary>Ответ</summary>
<br>

````
netology@microk8s:sudo vim /var/snap/microk8s/current/certs/csr.conf.template
...
Добавил строку:
IP.3 = 158.160.123.124
...
Обновил сертификат:
sudo microk8s refresh-certs --cert front-proxy-client.crt
Taking a backup of the current certificates under /var/snap/microk8s/6070/certs-backup/
Creating new certificates
Signature ok
subject=CN = front-proxy-client
Getting CA Private Key
Restarting service kubelite.

````   

</details>    

## Задание 2. Установка и настройка локального kubectl    

1. Установить на локальную машину kubectl.

<details>
<summary>Ответ</summary>
<br>

````
netology@microk8s:/var/snap/microk8s/current$ sudo curl -LO https://storage.googleapis.com/kubernetes-release/release/`sudo curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 47.5M  100 47.5M    0     0  19.9M      0  0:00:02  0:00:02 --:--:-- 19.9M
netology@microk8s:/var/snap/microk8s/current$ sudo chmod +x ./kubectl
netology@microk8s:/var/snap/microk8s/current$ sudo mv ./kubectl /usr/local/bin/kubectl
netology@microk8s:/var/snap/microk8s/current$ echo "source <(kubectl completion bash)" >> ~/.bashrc
netology@microk8s:/var/snap/microk8s/current$ source <(kubectl completion bash)

````   
</details>    

2. Настроить локально подключение к кластеру.

<details>
<summary>Ответ</summary>
<br>   

````   
netology@microk8s:~$ sudo microk8s config > .kube/config
netology@microk8s:~$ kubectl get pods
No resources found in default namespace.   
````   
</details>   

3. Подключиться к дашборду с помощью port-forward.     

<details>
<summary>Ответ</summary>
<br>   
  
````   
netology@microk8s:~$ sudo microk8s kubectl port-forward -n kube-system service/kubernetes-dashboard 10443:443 --address 0.0.0.0
Forwarding from 0.0.0.0:10443 -> 8443
````
![Снимок экрана 2023-10-28 в 11 16 16](https://github.com/tomaevmax/devops-netology/assets/32243921/c96c0d20-50ce-4cf1-acf7-08a3aa8429b3)

</details>    
