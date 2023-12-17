# Домашнее задание к занятию «Вычислительные мощности. Балансировщики нагрузки»  

## Задание 1. Yandex Cloud 

**Что нужно сделать**

1. Создать бакет Object Storage и разместить в нём файл с картинкой:

 - Создать бакет в Object Storage с произвольным именем (например, _имя_студента_дата_).
 - Положить в бакет файл с картинкой.
 - Сделать файл доступным из интернета.
 
2. Создать группу ВМ в public подсети фиксированного размера с шаблоном LAMP и веб-страницей, содержащей ссылку на картинку из бакета:

 - Создать Instance Group с тремя ВМ и шаблоном LAMP. Для LAMP рекомендуется использовать `image_id = fd827b91d99psvq5fjit`.
 - Для создания стартовой веб-страницы рекомендуется использовать раздел `user_data` в [meta_data](https://cloud.yandex.ru/docs/compute/concepts/vm-metadata).
 - Разместить в стартовой веб-странице шаблонной ВМ ссылку на картинку из бакета.
 - Настроить проверку состояния ВМ.
 
3. Подключить группу к сетевому балансировщику:

 - Создать сетевой балансировщик.
 - Проверить работоспособность, удалив одну или несколько ВМ.
4. (дополнительно)* Создать Application Load Balancer с использованием Instance group и проверкой состояния.

<details>
<summary>Ответ</summary>
<br>   

Все описаные задачи реализованы по средства терраформ, конфигурация доступна по ссылке: [main.tf](/src/main.tf)

Создаем инфраструктуру
````   
Plan: 10 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

yandex_iam_service_account.sa: Creating...
yandex_compute_image.lamp-vm-image: Creating...
yandex_vpc_network.cloud: Creating...
yandex_vpc_network.cloud: Creation complete after 3s [id=enp158htpm1v0j7v4muh]
yandex_vpc_subnet.public: Creating...
yandex_iam_service_account.sa: Creation complete after 3s [id=aje5nf5cuau6l01jka05]
yandex_iam_service_account_static_access_key.sa-static-key: Creating...
yandex_resourcemanager_folder_iam_member.sa-editor: Creating...
yandex_vpc_subnet.public: Creation complete after 1s [id=e9b27823jqanfhe1fr61]
yandex_iam_service_account_static_access_key.sa-static-key: Creation complete after 2s [id=ajej7lrdg6adh7tkvrt1]
yandex_storage_bucket.cloud-dz2: Creating...
yandex_resourcemanager_folder_iam_member.sa-editor: Creation complete after 3s [id=b1gb1aal3vgk7p7nr6nd/storage.editor/serviceAccount:aje5nf5cuau6l01jka05]
yandex_compute_image.lamp-vm-image: Creation complete after 9s [id=fd8lhkraaj5tllm1eaao]
yandex_compute_instance_group.lamp-group: Creating...
yandex_storage_bucket.cloud-dz2: Still creating... [10s elapsed]
yandex_compute_instance_group.lamp-group: Still creating... [10s elapsed]
yandex_storage_bucket.cloud-dz2: Still creating... [20s elapsed]
yandex_compute_instance_group.lamp-group: Still creating... [20s elapsed]
yandex_storage_bucket.cloud-dz2: Still creating... [30s elapsed]
yandex_compute_instance_group.lamp-group: Still creating... [30s elapsed]
yandex_storage_bucket.cloud-dz2: Still creating... [40s elapsed]
yandex_compute_instance_group.lamp-group: Still creating... [40s elapsed]
yandex_storage_bucket.cloud-dz2: Still creating... [50s elapsed]
yandex_compute_instance_group.lamp-group: Still creating... [50s elapsed]
yandex_storage_bucket.cloud-dz2: Still creating... [1m0s elapsed]
yandex_compute_instance_group.lamp-group: Still creating... [1m0s elapsed]
yandex_storage_bucket.cloud-dz2: Still creating... [1m10s elapsed]
yandex_compute_instance_group.lamp-group: Still creating... [1m10s elapsed]
yandex_storage_bucket.cloud-dz2: Still creating... [1m20s elapsed]
yandex_compute_instance_group.lamp-group: Still creating... [1m20s elapsed]
yandex_storage_bucket.cloud-dz2: Still creating... [1m30s elapsed]
yandex_compute_instance_group.lamp-group: Still creating... [1m30s elapsed]
yandex_storage_bucket.cloud-dz2: Still creating... [1m40s elapsed]
yandex_compute_instance_group.lamp-group: Still creating... [1m40s elapsed]
yandex_storage_bucket.cloud-dz2: Still creating... [1m50s elapsed]
yandex_compute_instance_group.lamp-group: Still creating... [1m50s elapsed]
yandex_storage_bucket.cloud-dz2: Still creating... [2m0s elapsed]
yandex_storage_bucket.cloud-dz2: Creation complete after 2m3s [id=cloud-dz2-picture]
yandex_storage_object.image-object: Creating...
yandex_storage_object.image-object: Creation complete after 1s [id=test.png]
yandex_compute_instance_group.lamp-group: Still creating... [2m0s elapsed]
yandex_compute_instance_group.lamp-group: Still creating... [2m10s elapsed]
yandex_compute_instance_group.lamp-group: Still creating... [2m20s elapsed]
yandex_compute_instance_group.lamp-group: Still creating... [2m30s elapsed]
yandex_compute_instance_group.lamp-group: Still creating... [2m40s elapsed]
yandex_compute_instance_group.lamp-group: Still creating... [2m50s elapsed]
yandex_compute_instance_group.lamp-group: Still creating... [3m0s elapsed]
yandex_compute_instance_group.lamp-group: Still creating... [3m10s elapsed]
yandex_compute_instance_group.lamp-group: Still creating... [3m20s elapsed]
yandex_compute_instance_group.lamp-group: Still creating... [3m30s elapsed]
yandex_compute_instance_group.lamp-group: Still creating... [3m40s elapsed]
yandex_compute_instance_group.lamp-group: Still creating... [3m50s elapsed]
yandex_compute_instance_group.lamp-group: Creation complete after 3m56s [id=cl1khvrddk9mvnco60fc]
yandex_lb_network_load_balancer.test-lb: Creating...
yandex_lb_network_load_balancer.test-lb: Creation complete after 3s [id=enpomngr3m2eo09epri7]

Apply complete! Resources: 10 added, 0 changed, 0 destroyed.

➜  src git:(cloud-02) ✗ yc compute instance list  
+----------------------+---------------------------+---------------+---------+-----------------+---------------+
|          ID          |           NAME            |    ZONE ID    | STATUS  |   EXTERNAL IP   |  INTERNAL IP  |
+----------------------+---------------------------+---------------+---------+-----------------+---------------+
| fhm0qeu8nke0h35tjgq7 | cl1khvrddk9mvnco60fc-ofof | ru-central1-a | RUNNING | 158.160.106.19  | 192.168.10.6  |
| fhmfh4l2mi11i72e36un | cl1khvrddk9mvnco60fc-ywun | ru-central1-a | RUNNING | 158.160.118.107 | 192.168.10.13 |
| fhmphkbolmd5nt9e1cu6 | cl1khvrddk9mvnco60fc-uqoj | ru-central1-a | RUNNING | 84.252.128.91   | 192.168.10.15 |
+----------------------+---------------------------+---------------+---------+-----------------+---------------+

➜  src git:(cloud-02) ✗ yc load-balancer network-load-balancer list
+----------------------+-------------------------+-------------+----------+----------------+------------------------+--------+
|          ID          |          NAME           |  REGION ID  |   TYPE   | LISTENER COUNT | ATTACHED TARGET GROUPS | STATUS |
+----------------------+-------------------------+-------------+----------+----------------+------------------------+--------+
| enpomngr3m2eo09epri7 | network-load-balancer-1 | ru-central1 | EXTERNAL |              1 | enpq3dbuth7rp78p5386   | ACTIVE |
+----------------------+-------------------------+-------------+----------+----------------+------------------------+--------+

➜  src git:(cloud-02) ✗ yc load-balancer network-load-balancer get --name network-load-balancer-1 
id: enpomngr3m2eo09epri7
folder_id: b1gb1aal3vgk7p7nr6nd
created_at: "2023-12-17T11:58:45Z"
name: network-load-balancer-1
region_id: ru-central1
status: ACTIVE
type: EXTERNAL
listeners:
  - name: network-load-balancer-1-listener
    address: 158.160.132.132
    port: "80"
    protocol: TCP
    target_port: "80"
    ip_version: IPV4
attached_target_groups:
  - target_group_id: enpq3dbuth7rp78p5386
    health_checks:
      - name: http
        interval: 2s
        timeout: 1s
        unhealthy_threshold: "2"
        healthy_threshold: "2"
        http_options:
          port: "80"
          path: /index.html

➜  src git:(cloud-02) ✗ yc load-balancer target-group get --name  lamp-server
id: enpq3dbuth7rp78p5386
folder_id: b1gb1aal3vgk7p7nr6nd
created_at: "2023-12-17T11:54:55Z"
name: lamp-server
description: test balanser
region_id: ru-central1
targets:
  - subnet_id: e9b27823jqanfhe1fr61
    address: 192.168.10.13
  - subnet_id: e9b27823jqanfhe1fr61
    address: 192.168.10.15
  - subnet_id: e9b27823jqanfhe1fr61
    address: 192.168.10.6


````    
Проверям доступность картинки из интернета запросом до сервера

````   
➜  src git:(cloud-02) ✗ curl -v http:// 158.160.106.19
* URL rejected: No host part in the URL
* Closing connection
curl: (3) URL rejected: No host part in the URL
*   Trying 158.160.106.19:80...
* Connected to 158.160.106.19 (158.160.106.19) port 80
> GET / HTTP/1.1
> Host: 158.160.106.19
> User-Agent: curl/8.4.0
> Accept: */*
> 
< HTTP/1.1 200 OK
< Date: Sun, 17 Dec 2023 12:04:58 GMT
< Server: Apache/2.4.29 (Ubuntu)
< Last-Modified: Sun, 17 Dec 2023 11:56:59 GMT
< ETag: "85-60cb354a92b20"
< Accept-Ranges: bytes
< Content-Length: 133
< Vary: Accept-Encoding
< Content-Type: text/html
< 
<html><head><title>Test image</title></head><body><img src=https://storage.yandexcloud.net/cloud-dz2-picture/test.png></body></html>
* Connection #0 to host 158.160.106.19 left intact

````   
Проверяем доступность картинки из интернета запросом до балансира

````   
➜  src git:(cloud-02) ✗ curl -v http://158.160.132.132
*   Trying 158.160.132.132:80...
* Connected to 158.160.132.132 (158.160.132.132) port 80
> GET / HTTP/1.1
> Host: 158.160.132.132
> User-Agent: curl/8.4.0
> Accept: */*
> 
< HTTP/1.1 200 OK
< Date: Sun, 17 Dec 2023 12:06:17 GMT
< Server: Apache/2.4.29 (Ubuntu)
< Last-Modified: Sun, 17 Dec 2023 11:57:10 GMT
< ETag: "85-60cb35558d3e0"
< Accept-Ranges: bytes
< Content-Length: 133
< Vary: Accept-Encoding
< Content-Type: text/html
< 
<html><head><title>Test image</title></head><body><img src=https://storage.yandexcloud.net/cloud-dz2-picture/test.png></body></html>
* Connection #0 to host 158.160.132.132 left intact
  
````   
Удаляем одну ноду и проверям доступность через балансир

````   
➜  src git:(cloud-02) ✗ yc compute instance list
+----------------------+---------------------------+---------------+---------+-----------------+---------------+
|          ID          |           NAME            |    ZONE ID    | STATUS  |   EXTERNAL IP   |  INTERNAL IP  |
+----------------------+---------------------------+---------------+---------+-----------------+---------------+
| fhm0qeu8nke0h35tjgq7 | cl1khvrddk9mvnco60fc-ofof | ru-central1-a | RUNNING | 158.160.106.19  | 192.168.10.6  |
| fhmfh4l2mi11i72e36un | cl1khvrddk9mvnco60fc-ywun | ru-central1-a | RUNNING | 158.160.118.107 | 192.168.10.13 |
| fhmphkbolmd5nt9e1cu6 | cl1khvrddk9mvnco60fc-uqoj | ru-central1-a | RUNNING | 84.252.128.91   | 192.168.10.15 |
+----------------------+---------------------------+---------------+---------+-----------------+---------------+

➜  src git:(cloud-02) ✗ yc compute instance delete --name cl1khvrddk9mvnco60fc-ofof
done (43s)
➜  src git:(cloud-02) ✗ yc compute instance list                                   
+----------------------+---------------------------+---------------+---------+-----------------+---------------+
|          ID          |           NAME            |    ZONE ID    | STATUS  |   EXTERNAL IP   |  INTERNAL IP  |
+----------------------+---------------------------+---------------+---------+-----------------+---------------+
| fhmfh4l2mi11i72e36un | cl1khvrddk9mvnco60fc-ywun | ru-central1-a | RUNNING | 158.160.118.107 | 192.168.10.13 |
| fhmphkbolmd5nt9e1cu6 | cl1khvrddk9mvnco60fc-uqoj | ru-central1-a | RUNNING | 84.252.128.91   | 192.168.10.15 |
+----------------------+---------------------------+---------------+---------+-----------------+---------------+

➜  src git:(cloud-02) ✗ curl -v http://158.160.132.132                             
*   Trying 158.160.132.132:80...
* Connected to 158.160.132.132 (158.160.132.132) port 80
> GET / HTTP/1.1
> Host: 158.160.132.132
> User-Agent: curl/8.4.0
> Accept: */*
> 
< HTTP/1.1 200 OK
< Date: Sun, 17 Dec 2023 12:08:49 GMT
< Server: Apache/2.4.29 (Ubuntu)
< Last-Modified: Sun, 17 Dec 2023 11:57:05 GMT
< ETag: "85-60cb3550295c0"
< Accept-Ranges: bytes
< Content-Length: 133
< Vary: Accept-Encoding
< Content-Type: text/html
< 
<html><head><title>Test image</title></head><body><img src=https://storage.yandexcloud.net/cloud-dz2-picture/test.png></body></html>
* Connection #0 to host 158.160.132.132 left intact

````
</details>