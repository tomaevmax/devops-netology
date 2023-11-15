# Домашнее задание к занятию «Хранение в K8s. Часть 2»

### Задание 1

**Что нужно сделать**

Создать Deployment приложения, использующего локальный PV, созданный вручную.

1. Создать Deployment приложения, состоящего из контейнеров busybox и multitool.
2. Создать PV и PVC для подключения папки на локальной ноде, которая будет использована в поде.
3. Продемонстрировать, что multitool может читать файл, в который busybox пишет каждые пять секунд в общей директории. 
4. Удалить Deployment и PVC. Продемонстрировать, что после этого произошло с PV. Пояснить, почему.
5. Продемонстрировать, что файл сохранился на локальном диске ноды. Удалить PV.  Продемонстрировать что произошло с файлом после удаления PV. Пояснить, почему.
6. Предоставить манифесты, а также скриншоты или вывод необходимых команд.


<details>
<summary>Ответ</summary>
<br>   

[deployment_pvc](/deployment_pvc.yaml)   
[pvc](/pvc.yaml)   
[pv](/pv.yaml)   

````  
netology@microk8s:~$ kubectl apply -f pc.yaml
persistentvolume/local-data created
netology@microk8s:~$ kubectl apply -f pvc.yaml 
persistentvolumeclaim/mydata created
netology@microk8s:~$ kubectl apply -f deployment_pvc.yaml 
deployment.apps/backend created
netology@microk8s:~$ kubectl get pv
NAME         CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM            STORAGECLASS    REASON   AGE
local-data   5Gi        RWO            Recycle          Bound    default/mydata   local-storage            20s
netology@microk8s:~$ kubectl get pvc
NAME     STATUS   VOLUME       CAPACITY   ACCESS MODES   STORAGECLASS    AGE
mydata   Bound    local-data   5Gi        RWO            local-storage   19s
netology@microk8s:~$ kubectl get pods
NAME                       READY   STATUS    RESTARTS   AGE
backend-6fff659bcc-wkclq   2/2     Running   0          18s
netology@microk8s:~$ ls /opt/data/
success.txt
netology@microk8s:~$ kubectl exec -it -c multitool backend-6fff659bcc-wkclq sh
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
/ # cat /opt/success.txt 
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
/ # cat /opt/success.txt 
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
/ # exit
netology@microk8s:~$ kubectl delete -f deployment_pvc.yaml 
deployment.apps "backend" deleted
netology@microk8s:~$ kubectl delete -f pvc.yaml 
persistentvolumeclaim "mydata" deleted
netology@microk8s:~$ kubectl describe pv
Name:            local-data
Labels:          <none>
Annotations:     <none>
Finalizers:      [kubernetes.io/pv-protection]
StorageClass:    local-storage
Status:          Available
Claim:           
Reclaim Policy:  Recycle
Access Modes:    RWO
VolumeMode:      Filesystem
Capacity:        5Gi
Node Affinity:   <none>
Message:         
Source:
    Type:          HostPath (bare host directory volume)
    Path:          /opt/data
    HostPathType:  
Events:
  Type    Reason          Age   From                         Message
  ----    ------          ----  ----                         -------
  Normal  RecyclerPod     27s   persistentvolume-controller  Recycler pod: Successfully assigned default/recycler-for-local-data to microk8s
  Normal  RecyclerPod     27s   persistentvolume-controller  Recycler pod: Pulling image "registry.k8s.io/debian-base:v2.0.0"
  Normal  RecyclerPod     24s   persistentvolume-controller  Recycler pod: Successfully pulled image "registry.k8s.io/debian-base:v2.0.0" in 3.037s (3.037s including waiting)
  Normal  RecyclerPod     23s   persistentvolume-controller  Recycler pod: Created container pv-recycler
  Normal  RecyclerPod     23s   persistentvolume-controller  Recycler pod: Started container pv-recycler
  Normal  VolumeRecycled  21s   persistentvolume-controller  Volume recycled
netology@microk8s:~$ ls /opt/data/
netology@microk8s:~$ kubectl delete -f pc.yaml 
persistentvolume "local-data" deleted
netology@microk8s:~$ ls -la /opt/data/
total 8
drwxr-xr-x 2 root root 4096 Nov 15 04:04 .
drwxr-xr-x 4 root root 4096 Nov 15 04:00 ..


````   
В соответствии с выбранной политикой хранения persistentVolumeReclaimPolicy: Recycle к файлам в хранилище после удаления 
PVC было применено правило : basic scrub (rm -rf /thevolume/*) , файлы были удалены.

</details>   

------

### Задание 2

**Что нужно сделать**

Создать Deployment приложения, которое может хранить файлы на NFS с динамическим созданием PV.

1. Включить и настроить NFS-сервер на MicroK8S.
2. Создать Deployment приложения состоящего из multitool, и подключить к нему PV, созданный автоматически на сервере NFS.
3. Продемонстрировать возможность чтения и записи файла изнутри пода. 
4. Предоставить манифесты, а также скриншоты или вывод необходимых команд.

<details>
<summary>Ответ</summary>
<br>   

[deployment_nfc](/deployment_nfc.yaml)   
[pvc_nfc](/pvc_nfc.yaml)   
[sc](/sc_nfc.yaml)   

````  
netology@microk8s:~/k8s$ kubectl get po -w
NAME                     READY   STATUS    RESTARTS   AGE
my-nfs-7cf995d66-jsrzv   1/1     Running   0          56s
^Cnetology@microk8s:~/k8skubectl exec -it my-nfs-7cf995d66-jsrzv -- sh
/ # cd /share/
/share # ls
/share # touch test.txt
/share # ls
test.txt
/share # echo 'test' >  test.txt 
/share # cat test.txt 
test


````   


</details>   

------

















# Домашнее задание к занятию «Хранение в K8s. Часть 1»

### Задание 1 

**Что нужно сделать**

Создать Deployment приложения, состоящего из двух контейнеров и обменивающихся данными.

1. Создать Deployment приложения, состоящего из контейнеров busybox и multitool.
2. Сделать так, чтобы busybox писал каждые пять секунд в некий файл в общей директории.
3. Обеспечить возможность чтения файла контейнером multitool.
4. Продемонстрировать, что multitool может читать файл, который периодоически обновляется.
5. Предоставить манифесты Deployment в решении, а также скриншоты или вывод команды из п. 4.

<details>
<summary>Ответ</summary>
<br>   

[deployment_share](/deployment_pvc.yaml)   

````  
netology@microk8s:~$ kubectl exec -it  backend-74c66f486d-bjvcc -c multitool sh
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
/ # ls
bin     certs   dev     docker  etc     home    lib     media   mnt     opt     proc    root    run     sbin    srv     sys     tmp     usr     var
/ # cd opt/
/opt # ls
success.txt
/opt # tail -f success.txt 
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
^C
/opt # tail -f success.txt 
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
Success!
^C
/opt # 

````   

</details>   



------

### Задание 2

**Что нужно сделать**

Создать DaemonSet приложения, которое может прочитать логи ноды.

1. Создать DaemonSet приложения, состоящего из multitool.
2. Обеспечить возможность чтения файла `/var/log/syslog` кластера MicroK8S.
3. Продемонстрировать возможность чтения файла изнутри пода.
4. Предоставить манифесты Deployment, а также скриншоты или вывод команды из п. 2.

<details>
<summary>Ответ</summary>
<br>   

[deployment_deamonset](/deployment_deamonset.yaml)   

````  
netology@microk8s:~$ kubectl exec -it deamon-lxnvd sh
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
/ # cat /share/syslog | grep "Created slice User"
Nov  9 03:35:06 microk8s kernel: [    5.128803] systemd[1]: Created slice User and Session Slice.
Nov  9 03:35:28 microk8s systemd[1]: Created slice User Slice of UID 1000.
Nov  9 03:35:28 microk8s systemd[1039]: Created slice User Application Slice.


````   

</details>   
  