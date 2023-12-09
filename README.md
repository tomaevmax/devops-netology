# Домашнее задание к занятию «Обновление приложений»

### Задание 1. Выбрать стратегию обновления приложения и описать ваш выбор

1. Имеется приложение, состоящее из нескольких реплик, которое требуется обновить.
2. Ресурсы, выделенные для приложения, ограничены, и нет возможности их увеличить.
3. Запас по ресурсам в менее загруженный момент времени составляет 20%.
4. Обновление мажорное, новые версии приложения не умеют работать со старыми.
5. Вам нужно объяснить свой выбор стратегии обновления приложения.

<details>
<summary>Ответ</summary>
<br>   
В требования не указанны критерии доступности для клиентов.
Под указанные требования подходят две стратегии Recreate Deployment и Rolling Update Deployment. 
Учитывая, что у нас есть запас по ресурсам в момент минимальной загрузки и во втором задании требуется обеспечить 
доступность, то обновление будем производить на основе стратегии Rolling Update Deployment, 
доступный ресурсов будем регулировать параметрами maxUnavailable and maxSurge.

[deployment](deployment.yaml)   
</details>   

### Задание 2. Обновить приложение

1. Создать deployment приложения с контейнерами nginx и multitool. Версию nginx взять 1.19. Количество реплик — 5.
2. Обновить версию nginx в приложении до версии 1.20, сократив время обновления до минимума. Приложение должно быть доступно.
3. Попытаться обновить nginx до версии 1.28, приложение должно оставаться доступным.
4. Откатиться после неудачного обновления.

<details>
<summary>Ответ</summary>
<br>   

````
 ➜  devops-netology git:(k8s_dz14) ✗ kubectl apply -n netology -f deployment.yaml
deployment.apps/nginx-deployment created

➜  devops-netology git:(k8s_dz14) ✗ kubectl describe -n netology deployment
Name:                   nginx-deployment
Namespace:              netology
CreationTimestamp:      Sat, 09 Dec 2023 09:27:09 +0300
Labels:                 app=nginx
Annotations:            deployment.kubernetes.io/revision: 1
Selector:               app=nginx
Replicas:               5 desired | 5 updated | 5 total | 5 available | 0 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  1 max unavailable, 1 max surge
Pod Template:
  Labels:  app=nginx
  Containers:
   nginx:
    Image:        nginx:1.14.2
    Port:         80/TCP
    Host Port:    0/TCP
    Environment:  <none>
    Mounts:       <none>
   multitool:
    Image:      wbitt/network-multitool
    Port:       <none>
    Host Port:  <none>
    Environment:
      HTTP_PORT:   1180
      HTTPS_PORT:  11443
    Mounts:        <none>
  Volumes:         <none>
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      True    MinimumReplicasAvailable
  Progressing    True    NewReplicaSetAvailable
OldReplicaSets:  <none>
NewReplicaSet:   nginx-deployment-75c698b7d4 (5/5 replicas created)
Events:
  Type    Reason             Age   From                   Message
  ----    ------             ----  ----                   -------
  Normal  ScalingReplicaSet  46s   deployment-controller  Scaled up replica set nginx-deployment-75c698b7d4 to 5

➜  devops-netology git:(k8s_dz14) ✗ kubectl apply -n netology -f deployment.yaml
deployment.apps/nginx-deployment configured
➜  devops-netology git:(k8s_dz14) ✗ kubectl describe -n netology deployment     
Name:                   nginx-deployment
Namespace:              netology
CreationTimestamp:      Sat, 09 Dec 2023 09:27:09 +0300
Labels:                 app=nginx
Annotations:            deployment.kubernetes.io/revision: 2
Selector:               app=nginx
Replicas:               5 desired | 2 updated | 6 total | 4 available | 2 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  1 max unavailable, 1 max surge
Pod Template:
  Labels:  app=nginx
  Containers:
   nginx:
    Image:        nginx:1.20
    Port:         80/TCP
    Host Port:    0/TCP
    Environment:  <none>
    Mounts:       <none>
   multitool:
    Image:      wbitt/network-multitool
    Port:       <none>
    Host Port:  <none>
    Environment:
      HTTP_PORT:   1180
      HTTPS_PORT:  11443
    Mounts:        <none>
  Volumes:         <none>
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      True    MinimumReplicasAvailable
  Progressing    True    ReplicaSetUpdated
OldReplicaSets:  nginx-deployment-75c698b7d4 (4/4 replicas created)
NewReplicaSet:   nginx-deployment-595bc9cd45 (2/2 replicas created)
Events:
  Type    Reason             Age    From                   Message
  ----    ------             ----   ----                   -------
  Normal  ScalingReplicaSet  2m47s  deployment-controller  Scaled up replica set nginx-deployment-75c698b7d4 to 5
  Normal  ScalingReplicaSet  3s     deployment-controller  Scaled up replica set nginx-deployment-595bc9cd45 to 1
  Normal  ScalingReplicaSet  3s     deployment-controller  Scaled down replica set nginx-deployment-75c698b7d4 to 4 from 5
  Normal  ScalingReplicaSet  3s     deployment-controller  Scaled up replica set nginx-deployment-595bc9cd45 to 2 from 1

 ➜  devops-netology git:(k8s_dz14) ✗ kubectl get -n netology pod            
NAME                                READY   STATUS    RESTARTS   AGE
nginx-deployment-595bc9cd45-qjfqc   2/2     Running   0          35s
nginx-deployment-595bc9cd45-fkmz5   2/2     Running   0          35s
nginx-deployment-595bc9cd45-mm5ml   2/2     Running   0          22s
nginx-deployment-595bc9cd45-mdv97   2/2     Running   0          22s
nginx-deployment-595bc9cd45-4gqx4   2/2     Running   0          19s

➜  devops-netology git:(k8s_dz14) ✗ kubectl apply -n netology -f deployment.yaml
deployment.apps/nginx-deployment configured
➜  devops-netology git:(k8s_dz14) ✗ kubectl describe -n netology deployment     
Name:                   nginx-deployment
Namespace:              netology
CreationTimestamp:      Sat, 09 Dec 2023 09:27:09 +0300
Labels:                 app=nginx
Annotations:            deployment.kubernetes.io/revision: 3
Selector:               app=nginx
Replicas:               5 desired | 2 updated | 6 total | 4 available | 2 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  1 max unavailable, 1 max surge
Pod Template:
  Labels:  app=nginx
  Containers:
   nginx:
    Image:        nginx:1.28
    Port:         80/TCP
    Host Port:    0/TCP
    Environment:  <none>
    Mounts:       <none>
   multitool:
    Image:      wbitt/network-multitool
    Port:       <none>
    Host Port:  <none>
    Environment:
      HTTP_PORT:   1180
      HTTPS_PORT:  11443
    Mounts:        <none>
  Volumes:         <none>
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      True    MinimumReplicasAvailable
  Progressing    True    ReplicaSetUpdated
OldReplicaSets:  nginx-deployment-75c698b7d4 (0/0 replicas created), nginx-deployment-595bc9cd45 (4/4 replicas created)
NewReplicaSet:   nginx-deployment-bd5dd5dc7 (2/2 replicas created)
Events:
  Type    Reason             Age               From                   Message
  ----    ------             ----              ----                   -------
  Normal  ScalingReplicaSet  4m4s              deployment-controller  Scaled up replica set nginx-deployment-75c698b7d4 to 5
  Normal  ScalingReplicaSet  80s               deployment-controller  Scaled up replica set nginx-deployment-595bc9cd45 to 1
  Normal  ScalingReplicaSet  80s               deployment-controller  Scaled down replica set nginx-deployment-75c698b7d4 to 4 from 5
  Normal  ScalingReplicaSet  80s               deployment-controller  Scaled up replica set nginx-deployment-595bc9cd45 to 2 from 1
  Normal  ScalingReplicaSet  67s               deployment-controller  Scaled down replica set nginx-deployment-75c698b7d4 to 3 from 4
  Normal  ScalingReplicaSet  67s               deployment-controller  Scaled up replica set nginx-deployment-595bc9cd45 to 3 from 2
  Normal  ScalingReplicaSet  67s               deployment-controller  Scaled down replica set nginx-deployment-75c698b7d4 to 2 from 3
  Normal  ScalingReplicaSet  67s               deployment-controller  Scaled up replica set nginx-deployment-595bc9cd45 to 4 from 3
  Normal  ScalingReplicaSet  64s               deployment-controller  Scaled down replica set nginx-deployment-75c698b7d4 to 1 from 2
  Normal  ScalingReplicaSet  5s (x5 over 64s)  deployment-controller  (combined from similar events): Scaled up replica set nginx-deployment-bd5dd5dc7 to 2 from 1

➜  devops-netology git:(k8s_dz14) ✗ kubectl get -n netology pod                 
NAME                                READY   STATUS             RESTARTS   AGE
nginx-deployment-595bc9cd45-qjfqc   2/2     Running            0          93s
nginx-deployment-595bc9cd45-fkmz5   2/2     Running            0          93s
nginx-deployment-595bc9cd45-mm5ml   2/2     Running            0          80s
nginx-deployment-595bc9cd45-mdv97   2/2     Running            0          80s
nginx-deployment-bd5dd5dc7-787hl    1/2     ImagePullBackOff   0          18s
nginx-deployment-bd5dd5dc7-fvwx9    1/2     ImagePullBackOff   0          18s

➜  devops-netology git:(k8s_dz14) ✗ kubectl rollout -n netology undo deployment nginx-deployment
deployment.apps/nginx-deployment rolled back
➜  devops-netology git:(k8s_dz14) ✗ kubectl get -n netology pod                                 
NAME                                READY   STATUS    RESTARTS   AGE
nginx-deployment-595bc9cd45-qjfqc   2/2     Running   0          2m41s
nginx-deployment-595bc9cd45-fkmz5   2/2     Running   0          2m41s
nginx-deployment-595bc9cd45-mm5ml   2/2     Running   0          2m28s
nginx-deployment-595bc9cd45-mdv97   2/2     Running   0          2m28s
nginx-deployment-595bc9cd45-cwnwx   2/2     Running   0          5s
 
````   
</details>