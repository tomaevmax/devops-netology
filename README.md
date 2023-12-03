# Домашнее задание к занятию «Установка Kubernetes»

### Задание 1. Установить кластер k8s с 1 master node

1. Подготовка работы кластера из 5 нод: 1 мастер и 4 рабочие ноды.
2. В качестве CRI — containerd.
3. Запуск etcd производить на мастере.
4. Способ установки выбрать самостоятельно.

<details>
<summary>Ответ</summary>
<br>   

Установку будем проводить с помощью [Документация kubespray](https://kubespray.io/).   

Согласно рекомендациям воспользуемся готовым образом

docker run --rm -it --mount type=bind,source="${HOME}"/.ssh/id_ed25519,dst=/root/.ssh/id_rsa \
  quay.io/kubespray/kubespray:v2.23.1 bash

Заполним инвентории    

declare -a IPS=(10.128.0.17 10.128.0.7 10.128.0.15 10.128.0.18 10.128.0.10)
CONFIG_FILE=inventory/mycluster/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}

Запустим плайбук   
ansible-playbook -i inventory/mycluster/hosts.yaml  -u yc-user --become  cluster.yml

[Лог отработки плайбука](install.log)

Подключаем к мастер ноде и проверяем статус кластера:

````   
root@node1:~# kubectl get nodes -o wide
NAME    STATUS   ROLES           AGE   VERSION   INTERNAL-IP   EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION      CONTAINER-RUNTIME
node1   Ready    control-plane   20m   v1.27.7   10.128.0.17   <none>        Ubuntu 20.04.6 LTS   5.4.0-167-generic   containerd://1.7.5
node2   Ready    <none>          19m   v1.27.7   10.128.0.7    <none>        Ubuntu 20.04.6 LTS   5.4.0-167-generic   containerd://1.7.5
node3   Ready    <none>          19m   v1.27.7   10.128.0.15   <none>        Ubuntu 20.04.6 LTS   5.4.0-167-generic   containerd://1.7.5
node4   Ready    <none>          19m   v1.27.7   10.128.0.18   <none>        Ubuntu 20.04.6 LTS   5.4.0-167-generic   containerd://1.7.5
node5   Ready    <none>          19m   v1.27.7   10.128.0.10   <none>        Ubuntu 20.04.6 LTS   5.4.0-167-generic   containerd://1.7.5

````   

````  
root@node1:~# kubectl get pods -A
NAMESPACE     NAME                                       READY   STATUS    RESTARTS   AGE
kube-system   calico-kube-controllers-794577df96-rxw6m   1/1     Running   0          5m50s
kube-system   calico-node-2plh7                          1/1     Running   0          7m3s
kube-system   calico-node-b22qf                          1/1     Running   0          7m3s
kube-system   calico-node-dc5k2                          1/1     Running   0          7m3s
kube-system   calico-node-tl8k8                          1/1     Running   0          7m3s
kube-system   calico-node-x68kv                          1/1     Running   0          7m3s
kube-system   coredns-5c469774b8-dgm8h                   1/1     Running   0          5m2s
kube-system   coredns-5c469774b8-vptbh                   1/1     Running   0          5m16s
kube-system   dns-autoscaler-f455cf558-vjdct             1/1     Running   0          5m9s
kube-system   kube-apiserver-node1                       1/1     Running   1          8m57s
kube-system   kube-controller-manager-node1              1/1     Running   2          8m56s
kube-system   kube-proxy-2c49d                           1/1     Running   0          7m54s
kube-system   kube-proxy-d9pcq                           1/1     Running   0          7m54s
kube-system   kube-proxy-h8zv7                           1/1     Running   0          7m55s
kube-system   kube-proxy-mkkjd                           1/1     Running   0          7m55s
kube-system   kube-proxy-rrgqp                           1/1     Running   0          7m55s
kube-system   kube-scheduler-node1                       1/1     Running   1          8m56s
kube-system   nginx-proxy-node2                          1/1     Running   0          7m57s
kube-system   nginx-proxy-node3                          1/1     Running   0          7m58s
kube-system   nginx-proxy-node4                          1/1     Running   0          7m57s
kube-system   nginx-proxy-node5                          1/1     Running   0          7m59s
kube-system   nodelocaldns-5cd4b                         1/1     Running   0          5m7s
kube-system   nodelocaldns-6m5wl                         1/1     Running   0          5m7s
kube-system   nodelocaldns-h47dv                         1/1     Running   0          5m7s
kube-system   nodelocaldns-n4szr                         1/1     Running   0          5m7s
kube-system   nodelocaldns-vd4bs                         1/1     Running   0          5m7s
root@node1:~# 

````   

</details>