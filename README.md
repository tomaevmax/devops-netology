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

[deployment_share](/deployment_share.yaml)   

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
  