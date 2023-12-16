# Домашнее задание к занятию «Организация сети»

### Задание 1. Yandex Cloud

1. Создать пустую VPC. Выбрать зону.
2. Публичная подсеть.
 - Создать в VPC subnet с названием public, сетью 192.168.10.0/24.
 - Создать в этой подсети NAT-инстанс, присвоив ему адрес 192.168.10.254. В качестве image_id использовать fd80mrhj8fl2oe87o4e1.
 - Создать в этой публичной подсети виртуалку с публичным IP, подключиться к ней и убедиться, что есть доступ к интернету.
3. Приватная подсеть.
 - Создать в VPC subnet с названием private, сетью 192.168.20.0/24.
 - Создать route table. Добавить статический маршрут, направляющий весь исходящий трафик private сети в NAT-инстанс.
 - Создать в этой приватной подсети виртуалку с внутренним IP, подключиться к ней через виртуалку, созданную ранее, и убедиться, что есть доступ к интернету.

<details>
<summary>Ответ</summary>
<br>   

[main.tf](/src/main.tf)

Создаем инфраструктуру 
````   
Plan: 8 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

yandex_vpc_network.cloud: Creating...
yandex_compute_image.ubuntu-2204-lts: Creating...
yandex_vpc_network.cloud: Creation complete after 2s [id=enpv9brnm0fodun7ln9l]
yandex_vpc_route_table.cloud-rt: Creating...
yandex_vpc_subnet.public: Creating...
yandex_vpc_route_table.cloud-rt: Creation complete after 1s [id=enp2fhsamns2gq40vdni]
yandex_vpc_subnet.privat: Creating...
yandex_vpc_subnet.privat: Creation complete after 0s [id=e9bea5902lfjjvubj92c]
yandex_vpc_subnet.public: Creation complete after 2s [id=e9bkaaqfjuvvutrj0dfh]
yandex_compute_instance.nat-instance: Creating...
yandex_compute_image.ubuntu-2204-lts: Still creating... [10s elapsed]
yandex_compute_image.ubuntu-2204-lts: Creation complete after 13s [id=fd8ngac4duvs68rrtj9c]
yandex_compute_instance.test-vm: Creating...
yandex_compute_instance.test-vm2: Creating...
yandex_compute_instance.nat-instance: Still creating... [10s elapsed]
yandex_compute_instance.test-vm2: Still creating... [10s elapsed]
yandex_compute_instance.test-vm: Still creating... [10s elapsed]
yandex_compute_instance.nat-instance: Still creating... [20s elapsed]
yandex_compute_instance.test-vm2: Still creating... [20s elapsed]
yandex_compute_instance.test-vm: Still creating... [20s elapsed]
yandex_compute_instance.nat-instance: Still creating... [30s elapsed]
yandex_compute_instance.test-vm2: Still creating... [30s elapsed]
yandex_compute_instance.test-vm: Still creating... [30s elapsed]
yandex_compute_instance.nat-instance: Still creating... [40s elapsed]
yandex_compute_instance.test-vm: Still creating... [40s elapsed]
yandex_compute_instance.test-vm2: Still creating... [40s elapsed]
yandex_compute_instance.nat-instance: Still creating... [50s elapsed]
yandex_compute_instance.test-vm2: Still creating... [50s elapsed]
yandex_compute_instance.test-vm: Still creating... [50s elapsed]
yandex_compute_instance.nat-instance: Still creating... [1m0s elapsed]
yandex_compute_instance.nat-instance: Creation complete after 1m4s [id=fhmksljvfigon0gdlcmq]
yandex_compute_instance.test-vm: Still creating... [1m0s elapsed]
yandex_compute_instance.test-vm2: Still creating... [1m0s elapsed]
yandex_compute_instance.test-vm: Still creating... [1m10s elapsed]
yandex_compute_instance.test-vm2: Still creating... [1m10s elapsed]
yandex_compute_instance.test-vm2: Still creating... [1m20s elapsed]
yandex_compute_instance.test-vm: Still creating... [1m20s elapsed]
yandex_compute_instance.test-vm: Creation complete after 1m24s [id=fhml02kevai7n09mt9eh]
yandex_compute_instance.test-vm2: Still creating... [1m30s elapsed]
yandex_compute_instance.test-vm2: Creation complete after 1m40s [id=fhmte8fn86pi1vcpgd35]

Apply complete! Resources: 8 added, 0 changed, 0 destroyed.
➜  src git:(cloud-01) ✗ yc compute instance list                                  
+----------------------+-----------+---------------+---------+---------------+----------------+
|          ID          |   NAME    |    ZONE ID    | STATUS  |  EXTERNAL IP  |  INTERNAL IP   |
+----------------------+-----------+---------------+---------+---------------+----------------+
| fhmksljvfigon0gdlcmq | nat-vm    | ru-central1-a | RUNNING | 51.250.77.242 | 192.168.10.254 |
| fhml02kevai7n09mt9eh | public-vm | ru-central1-a | RUNNING | 51.250.5.75   | 192.168.10.31  |
| fhmte8fn86pi1vcpgd35 | privat-vm | ru-central1-a | RUNNING |               | 192.168.20.20  |
+----------------------+-----------+---------------+---------+---------------+----------------+

````    
Проверяем доступы в публичной подсети   
````
➜  src git:(cloud-01) ✗ ssh ubuntu@51.250.5.75 
The authenticity of host '51.250.5.75 (51.250.5.75)' can't be established.
ED25519 key fingerprint is SHA256:ayb3ApVdReCYwsgKuj2e4ipHZgAKvJq2hBFt5pTxyZA.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '51.250.5.75' (ED25519) to the list of known hosts.
Welcome to Ubuntu 22.04.3 LTS (GNU/Linux 5.15.0-89-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Sat Dec 16 07:31:39 AM UTC 2023

  System load:  1.67041015625     Processes:             137
  Usage of /:   53.8% of 7.79GB   Users logged in:       0
  Memory usage: 10%               IPv4 address for eth0: 192.168.10.31
  Swap usage:   0%


Expanded Security Maintenance for Applications is not enabled.

0 updates can be applied immediately.

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status


The list of available updates is more than a week old.
To check for new updates run: sudo apt update


The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

ubuntu@fhml02kevai7n09mt9eh:~$ ping 8.8.8.8
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
64 bytes from 8.8.8.8: icmp_seq=1 ttl=58 time=18.0 ms
64 bytes from 8.8.8.8: icmp_seq=2 ttl=58 time=18.0 ms
64 bytes from 8.8.8.8: icmp_seq=3 ttl=58 time=17.8 ms
64 bytes from 8.8.8.8: icmp_seq=4 ttl=58 time=18.2 ms
^C
--- 8.8.8.8 ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3003ms
rtt min/avg/max/mdev = 17.836/18.007/18.192/0.128 ms
````   
Проверяем доступ в приватной подсети
````   
➜  src git:(cloud-01) ✗ scp ~/.ssh/id_ed25519 ubuntu@51.250.5.75:.ssh/id_ed25519
id_ed25519                                                                                                                                                                                                                                                                       100%  411    13.5KB/s   00:00    
➜  src git:(cloud-01) ✗ ssh ubuntu@51.250.5.75                                  
Welcome to Ubuntu 22.04.3 LTS (GNU/Linux 5.15.0-89-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Sat Dec 16 07:32:54 AM UTC 2023

  System load:  0.57373046875     Processes:             136
  Usage of /:   53.8% of 7.79GB   Users logged in:       0
  Memory usage: 10%               IPv4 address for eth0: 192.168.10.31
  Swap usage:   0%


Expanded Security Maintenance for Applications is not enabled.

0 updates can be applied immediately.

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status


The list of available updates is more than a week old.
To check for new updates run: sudo apt update

Last login: Sat Dec 16 07:31:43 2023 from 109.248.252.157
To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

ubuntu@fhml02kevai7n09mt9eh:~$ ssh 192.168.20.20 
The authenticity of host '192.168.20.20 (192.168.20.20)' can't be established.
ED25519 key fingerprint is SHA256:FMU77HfHrK+fA+qShewlswUvzDNwemuxNoe0JSj01gQ.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '192.168.20.20' (ED25519) to the list of known hosts.
Welcome to Ubuntu 22.04.3 LTS (GNU/Linux 5.15.0-89-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Sat Dec 16 07:33:18 AM UTC 2023

  System load:  0.58154296875     Processes:             139
  Usage of /:   53.3% of 7.79GB   Users logged in:       0
  Memory usage: 10%               IPv4 address for eth0: 192.168.20.20
  Swap usage:   0%


Expanded Security Maintenance for Applications is not enabled.

0 updates can be applied immediately.

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status


The list of available updates is more than a week old.
To check for new updates run: sudo apt update


The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

ubuntu@fhmte8fn86pi1vcpgd35:~$ ping 8.8.8.8
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
64 bytes from 8.8.8.8: icmp_seq=1 ttl=54 time=19.5 ms
64 bytes from 8.8.8.8: icmp_seq=2 ttl=54 time=18.9 ms
64 bytes from 8.8.8.8: icmp_seq=3 ttl=54 time=18.9 ms
64 bytes from 8.8.8.8: icmp_seq=4 ttl=54 time=18.9 ms
^C
--- 8.8.8.8 ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3005ms
rtt min/avg/max/mdev = 18.876/19.047/19.463/0.241 ms

````    

</details>
 
