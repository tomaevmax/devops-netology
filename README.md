# Домашнее задание к занятию «Кластеры. Ресурсы под управлением облачных провайдеров»

## Задание 1. Yandex Cloud

1. Настроить с помощью Terraform кластер баз данных MySQL.

 - Используя настройки VPC из предыдущих домашних заданий, добавить дополнительно подсеть private в разных зонах, чтобы обеспечить отказоустойчивость. 
 - Разместить ноды кластера MySQL в разных подсетях.
 - Необходимо предусмотреть репликацию с произвольным временем технического обслуживания.
 - Использовать окружение Prestable, платформу Intel Broadwell с производительностью 50% CPU и размером диска 20 Гб.
 - Задать время начала резервного копирования — 23:59.
 - Включить защиту кластера от непреднамеренного удаления.
 - Создать БД с именем `netology_db`, логином и паролем.

2. Настроить с помощью Terraform кластер Kubernetes.

 - Используя настройки VPC из предыдущих домашних заданий, добавить дополнительно две подсети public в разных зонах, чтобы обеспечить отказоустойчивость.
 - Создать отдельный сервис-аккаунт с необходимыми правами. 
 - Создать региональный мастер Kubernetes с размещением нод в трёх разных подсетях.
 - Добавить возможность шифрования ключом из KMS, созданным в предыдущем домашнем задании.
 - Создать группу узлов, состояющую из трёх машин с автомасштабированием до шести.
 - Подключиться к кластеру с помощью `kubectl`.
 - *Запустить микросервис phpmyadmin и подключиться к ранее созданной БД.
 - *Создать сервис-типы Load Balancer и подключиться к phpmyadmin. Предоставить скриншот с публичным адресом и подключением к БД.

<details>
<summary>Ответ</summary>
<br>   

Все описанные задачи реализованы по средства терраформ, конфигурация доступна по ссылке: [main.tf](/src/main.tf)

Создаем инфраструктуру 

````   
Plan: 20 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

yandex_iam_service_account.test-k8s: Creating...
yandex_vpc_network.cloud: Creating...
yandex_kms_symmetric_key.kms-key: Creating...
yandex_kms_symmetric_key.kms-key: Creation complete after 1s [id=abj7vdjpuifctia9367k]
yandex_vpc_network.cloud: Creation complete after 2s [id=enpdsnanb850pt6phpkj]
yandex_vpc_subnet.public-b: Creating...
yandex_vpc_subnet.privat-a: Creating...
yandex_vpc_subnet.public-c: Creating...
yandex_vpc_subnet.privat-c: Creating...
yandex_vpc_subnet.public-a: Creating...
yandex_vpc_subnet.privat-b: Creating...
yandex_vpc_security_group.k8s-master-whitelist: Creating...
yandex_vpc_subnet.privat-c: Creation complete after 0s [id=b0c191l0qq0lo9ohrfg4]
yandex_vpc_security_group.k8s-master-whitelist: Creation complete after 1s [id=enpd8bs91hgb1he8tgep]
yandex_iam_service_account.test-k8s: Creation complete after 3s [id=aje7f55cqiq3k34uc5qn]
yandex_resourcemanager_folder_iam_member.images-puller: Creating...
yandex_resourcemanager_folder_iam_member.viewer: Creating...
yandex_resourcemanager_folder_iam_member.vpc-public-admin: Creating...
yandex_resourcemanager_folder_iam_member.k8s-clusters-agent: Creating...
yandex_vpc_subnet.public-b: Creation complete after 1s [id=e2lvhor80smgqsauuv23]
yandex_vpc_subnet.public-c: Creation complete after 2s [id=b0cor8perbhig87c6lh2]
yandex_vpc_subnet.privat-a: Creation complete after 2s [id=e9b4f0actilq8rka7bk7]
yandex_vpc_subnet.privat-b: Creation complete after 3s [id=e2l11oc7dusphfbusvkv]
yandex_mdb_mysql_cluster.test-mysql: Creating...
yandex_vpc_subnet.public-a: Creation complete after 4s [id=e9b985k30e1qq0hnempc]
yandex_vpc_security_group.k8s-main-sg: Creating...
yandex_resourcemanager_folder_iam_member.k8s-clusters-agent: Creation complete after 3s [id=b1gb1aal3vgk7p7nr6nd/k8s.clusters.agent/serviceAccount:aje7f55cqiq3k34uc5qn]
yandex_vpc_security_group.k8s-main-sg: Creation complete after 1s [id=enp9bvvjc017iu5s54ob]
yandex_resourcemanager_folder_iam_member.viewer: Creation complete after 5s [id=b1gb1aal3vgk7p7nr6nd/viewer/serviceAccount:aje7f55cqiq3k34uc5qn]
yandex_resourcemanager_folder_iam_member.images-puller: Creation complete after 8s [id=b1gb1aal3vgk7p7nr6nd/container-registry.images.puller/serviceAccount:aje7f55cqiq3k34uc5qn]
yandex_resourcemanager_folder_iam_member.vpc-public-admin: Still creating... [10s elapsed]
yandex_resourcemanager_folder_iam_member.vpc-public-admin: Creation complete after 11s [id=b1gb1aal3vgk7p7nr6nd/vpc.publicAdmin/serviceAccount:aje7f55cqiq3k34uc5qn]
yandex_kubernetes_cluster.k8s-regional: Creating...
yandex_mdb_mysql_cluster.test-mysql: Still creating... [10s elapsed]
yandex_kubernetes_cluster.k8s-regional: Still creating... [10s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [20s elapsed]
yandex_kubernetes_cluster.k8s-regional: Still creating... [20s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [30s elapsed]
yandex_kubernetes_cluster.k8s-regional: Still creating... [30s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [40s elapsed]
yandex_kubernetes_cluster.k8s-regional: Still creating... [40s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [50s elapsed]
yandex_kubernetes_cluster.k8s-regional: Still creating... [50s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [1m0s elapsed]
yandex_kubernetes_cluster.k8s-regional: Still creating... [1m0s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [1m10s elapsed]
yandex_kubernetes_cluster.k8s-regional: Still creating... [1m10s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [1m20s elapsed]
yandex_kubernetes_cluster.k8s-regional: Still creating... [1m20s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [1m30s elapsed]
yandex_kubernetes_cluster.k8s-regional: Still creating... [1m30s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [1m40s elapsed]
yandex_kubernetes_cluster.k8s-regional: Still creating... [1m40s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [1m50s elapsed]
yandex_kubernetes_cluster.k8s-regional: Still creating... [1m50s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [2m0s elapsed]
yandex_kubernetes_cluster.k8s-regional: Still creating... [2m0s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [2m10s elapsed]
yandex_kubernetes_cluster.k8s-regional: Still creating... [2m10s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [2m20s elapsed]
yandex_kubernetes_cluster.k8s-regional: Still creating... [2m20s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [2m30s elapsed]
yandex_kubernetes_cluster.k8s-regional: Still creating... [2m30s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [2m40s elapsed]
yandex_kubernetes_cluster.k8s-regional: Still creating... [2m40s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [2m50s elapsed]
yandex_kubernetes_cluster.k8s-regional: Still creating... [2m50s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [3m0s elapsed]
yandex_kubernetes_cluster.k8s-regional: Still creating... [3m0s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [3m10s elapsed]
yandex_kubernetes_cluster.k8s-regional: Still creating... [3m10s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [3m20s elapsed]
yandex_kubernetes_cluster.k8s-regional: Still creating... [3m20s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [3m30s elapsed]
yandex_kubernetes_cluster.k8s-regional: Still creating... [3m30s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [3m40s elapsed]
yandex_kubernetes_cluster.k8s-regional: Still creating... [3m40s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [3m50s elapsed]
yandex_kubernetes_cluster.k8s-regional: Still creating... [3m50s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [4m0s elapsed]
yandex_kubernetes_cluster.k8s-regional: Still creating... [4m0s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [4m10s elapsed]
yandex_kubernetes_cluster.k8s-regional: Still creating... [4m10s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [4m20s elapsed]
yandex_kubernetes_cluster.k8s-regional: Still creating... [4m20s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [4m30s elapsed]
yandex_kubernetes_cluster.k8s-regional: Still creating... [4m30s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [4m40s elapsed]
yandex_kubernetes_cluster.k8s-regional: Still creating... [4m40s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [4m50s elapsed]
yandex_kubernetes_cluster.k8s-regional: Still creating... [4m50s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [5m0s elapsed]
yandex_kubernetes_cluster.k8s-regional: Still creating... [5m0s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [5m10s elapsed]
yandex_kubernetes_cluster.k8s-regional: Creation complete after 5m2s [id=catplb8f13o68rndnuk8]
yandex_kubernetes_node_group.worker-node: Creating...
yandex_mdb_mysql_cluster.test-mysql: Still creating... [5m20s elapsed]
yandex_kubernetes_node_group.worker-node: Still creating... [10s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [5m30s elapsed]
yandex_kubernetes_node_group.worker-node: Still creating... [20s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [5m40s elapsed]
yandex_kubernetes_node_group.worker-node: Still creating... [30s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [5m50s elapsed]
yandex_kubernetes_node_group.worker-node: Still creating... [40s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [6m0s elapsed]
yandex_kubernetes_node_group.worker-node: Still creating... [50s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [6m10s elapsed]
yandex_kubernetes_node_group.worker-node: Still creating... [1m0s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [6m20s elapsed]
yandex_kubernetes_node_group.worker-node: Still creating... [1m10s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [6m30s elapsed]
yandex_kubernetes_node_group.worker-node: Still creating... [1m20s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [6m40s elapsed]
yandex_kubernetes_node_group.worker-node: Still creating... [1m30s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [6m50s elapsed]
yandex_kubernetes_node_group.worker-node: Creation complete after 1m39s [id=cat4k98397qgpskmii2d]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [7m0s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [7m10s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [7m20s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [7m30s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [7m40s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [7m50s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [8m0s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [8m10s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [8m20s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [8m30s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [8m40s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [8m50s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [9m0s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [9m10s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [9m20s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [9m30s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [9m40s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [9m50s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [10m0s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [10m10s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [10m20s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [10m30s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [10m40s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [10m50s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [11m0s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [11m10s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Still creating... [11m20s elapsed]
yandex_mdb_mysql_cluster.test-mysql: Creation complete after 11m27s [id=c9qm33r1m3645o89p7ea]
yandex_mdb_mysql_database.mydb: Creating...
yandex_mdb_mysql_user.admin: Creating...
yandex_mdb_mysql_database.mydb: Still creating... [10s elapsed]
yandex_mdb_mysql_user.admin: Still creating... [10s elapsed]
yandex_mdb_mysql_user.admin: Still creating... [20s elapsed]
yandex_mdb_mysql_database.mydb: Still creating... [20s elapsed]
yandex_mdb_mysql_database.mydb: Creation complete after 25s [id=c9qm33r1m3645o89p7ea:netology_db]
yandex_mdb_mysql_user.admin: Still creating... [30s elapsed]
yandex_mdb_mysql_user.admin: Still creating... [40s elapsed]
yandex_mdb_mysql_user.admin: Creation complete after 48s [id=c9qm33r1m3645o89p7ea:netology]
╷
│ Warning: Argument is deprecated
│ 
│   with yandex_kubernetes_node_group.worker-node,
│   on main.tf line 277, in resource "yandex_kubernetes_node_group" "worker-node":
│  277:       subnet_id = yandex_vpc_subnet.public-a.id
│ 
│ The 'subnet_id' field has been deprecated. Please use 'subnet_ids under network_interface' instead.
│ 
│ (and 2 more similar warnings elsewhere)
╵

Apply complete! Resources: 20 added, 0 changed, 0 destroyed.

````   
Смотрим в GUI состояния кластера mysql

![Снимок экрана 2023-12-24 в 15 23 42](https://github.com/tomaevmax/devops-netology/assets/32243921/33b5b4dd-e60b-41f2-9573-be50e9f8da21)


Подключаемся к кластеру Kubernetes по средствам kubctl

````   
➜  src git:(cloud-04) ✗ yc managed-kubernetes cluster get-credentials --id catplb8f13o68rndnuk8 --external


Context 'yc-managed-k8s-catplb8f13o68rndnuk8' was added as default to kubeconfig '/Users/maksimtomaev/.kube/config'.
Check connection to cluster using 'kubectl cluster-info --kubeconfig /Users/maksimtomaev/.kube/config'.

Note, that authentication depends on 'yc' and its config profile 'netology'.
To access clusters using the Kubernetes API, please use Kubernetes Service Account.
➜  src git:(cloud-04) ✗ kubectl get nodes                                                                 
NAME                                 STATUS   ROLES    AGE     VERSION
regional-eqer-cl1hl001e1nmg7aope6b   Ready    <none>   6m38s   v1.27.3
regional-ived-cl1hl001e1nmg7aope6b   Ready    <none>   6m28s   v1.27.3
regional-ohiz-cl1hl001e1nmg7aope6b   Ready    <none>   6m23s   v1.27.3

````    
 При выполнение этого пункта из второго задания:
 - Создать группу узлов, состояющую из трёх машин с автомасштабированием до шести.
 api вернуло ошибку, для регионального кластера требяется явная привязка группы узлов к зонам.
По итогу настроен региональный кластер с фиксированным количеством узлов.
</details>   
