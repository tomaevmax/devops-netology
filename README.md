# Домашнее задание к занятию «Helm»

### Задание 1. Подготовить Helm-чарт для приложения

1. Необходимо упаковать приложение в чарт для деплоя в разные окружения. 
2. Каждый компонент приложения деплоится отдельным deployment’ом или statefulset’ом.
3. В переменных чарта измените образ приложения для изменения версии.

<details>
<summary>Ответ</summary>
<br>   

[deployment](/nginx/templates/deployment.yaml)   
[nginx values](/nginx/nginx.yaml)   
[multitool values](/nginx/multitool.yaml)  

</details>

------
### Задание 2. Запустить две версии в разных неймспейсах

1. Подготовив чарт, необходимо его проверить. Запуститe несколько копий приложения.
2. Одну версию в namespace=app1, вторую версию в том же неймспейсе, третью версию в namespace=app2.
3. Продемонстрируйте результат.

<details>
<summary>Ответ</summary>
<br>   

Проверяем манифесты и values   

```   
➜  devops-netology git:(k8s_dz10) ✗ helm lint netology-app -f nginx/nginx.yaml               
==> Linting netology-app
Error unable to check Chart.yaml file in chart: stat netology-app/Chart.yaml: no such file or directory

Error: 1 chart(s) linted, 1 chart(s) failed
➜  devops-netology git:(k8s_dz10) ✗ helm lint netology-app -f nginx/multitool.yaml 
==> Linting netology-app
Error unable to check Chart.yaml file in chart: stat netology-app/Chart.yaml: no such file or directory

Error: 1 chart(s) linted, 1 chart(s) failed

```   
Ставим первую версию в ns app1
````   
➜  nginx git:(k8s_dz10) ✗ cat Chart.yaml | grep appVersion
appVersion: "1.0.0"

➜  devops-netology git:(k8s_dz10) ✗ helm upgrade --install --atomic netology-app-front nginx/ --namespace app1 -f nginx/nginx.yaml
Release "netology-app-front" does not exist. Installing it now.
NAME: netology-app-front
LAST DEPLOYED: Sat Nov 25 08:49:48 2023
NAMESPACE: app1
STATUS: deployed
REVISION: 1
NOTES:
1. Get the application URL by running these commands:
  export POD_NAME=$(kubectl get pods --namespace app1 -l "app.kubernetes.io/name=netology-app,app.kubernetes.io/instance=netology-app-front" -o jsonpath="{.items[0].metadata.name}")
  export CONTAINER_PORT=$(kubectl get pod --namespace app1 $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")
  echo "Visit http://127.0.0.1:8080 to use your application"
  kubectl --namespace app1 port-forward $POD_NAME 8080:$CONTAINER_PORT
➜  devops-netology git:(k8s_dz10) ✗ helm upgrade --install --atomic netology-app-back nginx/ --namespace app1 -f nginx/multitool.yaml
Release "netology-app-back" has been upgraded. Happy Helming!
NAME: netology-app-back
LAST DEPLOYED: Sat Nov 25 08:50:13 2023
NAMESPACE: app1
STATUS: deployed
REVISION: 2
NOTES:
1. Get the application URL by running these commands:
  export POD_NAME=$(kubectl get pods --namespace app1 -l "app.kubernetes.io/name=netology-app,app.kubernetes.io/instance=netology-app-back" -o jsonpath="{.items[0].metadata.name}")
  export CONTAINER_PORT=$(kubectl get pod --namespace app1 $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")
  echo "Visit http://127.0.0.1:8080 to use your application"
  kubectl --namespace app1 port-forward $POD_NAME 8080:$CONTAINER_PORT
➜  devops-netology git:(k8s_dz10) ✗ kubectl -n app1 get pods                                                                     
NAME                     READY   STATUS    RESTARTS   AGE
nginx-5994654c77-5b6zb   1/1     Running   0          33s
multitool-0              1/1     Running   0          8s

````   
Обновляем версию приложения до 1.1.0

````  
➜  devops-netology git:(k8s_dz10) ✗ cat nginx/Chart.yaml | grep appVersion
appVersion: "1.1.0"
➜  devops-netology git:(k8s_dz10) ✗ helm upgrade --install --atomic netology-app-back nginx/ --namespace app1 -f nginx/multitool.yaml
Release "netology-app-back" has been upgraded. Happy Helming!
NAME: netology-app-back
LAST DEPLOYED: Sat Nov 25 09:09:36 2023
NAMESPACE: app1
STATUS: deployed
REVISION: 4
➜  devops-netology git:(k8s_dz10) ✗ helm upgrade --install --atomic netology-app-front nginx/ --namespace app1 -f nginx/nginx.yaml   
Release "netology-app-front" has been upgraded. Happy Helming!
NAME: netology-app-front
LAST DEPLOYED: Sat Nov 25 09:09:42 2023
NAMESPACE: app1
STATUS: deployed
REVISION: 3
➜  devops-netology git:(k8s_dz10) ✗ kubectl -n app1 get pods
NAME                     READY   STATUS    RESTARTS   AGE
nginx-5994654c77-9278j   1/1     Running   0          60s
multitool-0              1/1     Running   0          44s

````   
Ставим третью версию в ns app2

````   
➜  devops-netology git:(k8s_dz10) ✗ cat nginx/Chart.yaml | grep appVersion
appVersion: "1.1.2"
➜  devops-netology git:(k8s_dz10) ✗ helm upgrade --install --atomic netology-app-front nginx/ --namespace app2 -f nginx/nginx.yaml
Release "netology-app-front" does not exist. Installing it now.
NAME: netology-app-front
LAST DEPLOYED: Sat Nov 25 09:13:25 2023
NAMESPACE: app2
STATUS: deployed
REVISION: 1
➜  devops-netology git:(k8s_dz10) ✗ helm upgrade --install --atomic netology-app-back nginx/ --namespace app2 -f nginx/multitool.yaml
Release "netology-app-back" does not exist. Installing it now.
NAME: netology-app-back
LAST DEPLOYED: Sat Nov 25 09:13:42 2023
NAMESPACE: app2
STATUS: deployed
REVISION: 1
➜  devops-netology git:(k8s_dz10) ✗ kubectl -n app2 get pods                                                                  
NAME                     READY   STATUS    RESTARTS   AGE
nginx-5994654c77-gkvcg   1/1     Running   0          26s
multitool-0              1/1     Running   0          9s

````   

</details>