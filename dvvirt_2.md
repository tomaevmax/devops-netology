Задача 1  

 .Опишите основные преимущества применения на практике IaaC-паттернов.  

  Преимущество применения паттернов IaaС на практике это возможность единожды описав инфраструктуру многократно её воспроизводить, производить развёртывние идентичных сервера/сред для тестирования/разработки, масштабирование при необходимости. Следующим преимуществом является автоматизация рутинных действий что приводит к снижению трудозатрат на их выполнение - как следствие повышается скорость разработки, выявления и устранения дефектов за счёт более раннего их обнаружения и тестирования на этапе сборки. Автоматизация поставки - позволяет сократить время от этапа разработки до внедрения. Паттерны IaaC позволяют стандартизировать развёртывание инфраструктуры, что снижает вероятность появления ошибок или отклонений связанных с человеческим фактором.  
  Применение на практике IaaC паттернов позволяет ускорить процесс разработки, снизить трудозатраты на поиск и устранение дефектов, организовать непрерывную поставку продукта  

 .Какой из принципов IaaC является основополагающим?  

  Идемпотентность операций - свойство сценария/операции позволяющее многократно получать/воспроизводить одно и то же состояние объекта (среды) что и при первом применении, т.е. не зависимо от того сколько раз будет проигран сценарий, результат всегда будет идентичен результату полученному в первый раз.  
  
Задача 2  
  
 .Чем Ansible выгодно отличается от других систем управление конфигурациями?  

  Не требует установки агентов на клиентах, использует SSH или WinRM соединение. Низкий порог входа, поддержка декларативного и императивного подхода, описание конфигурации - «плейбуки» вформате YAML Поддерживает широкий набор модулей позволяющих управлять конфигурацией как ОС, так и различным ПО и сетевым оборудованием. Ansible Galaxy - публичный репозиторий, в котором размещается огромное количество готовых ролей Ansible.  

 .Какой, на ваш взгляд, метод работы систем конфигурации более надёжный push или pull?  
  
  На мой взгляд более надёжный push - позволяет определить когда, кдуа и какую конфигурацию отправить, так же позволяет проконтролировать результат применения.  
  
Задача 3  
  
Установите на личный компьютер:  
  
  - VirtualBox  
    Версия 6.1.44 r156814
 - vagrant  
    max@max:~/vagrant$ vagrant --version  
    Vagrant 2.2.19
 - Ansible  
   max@max:~/vagrant$ ansible --version  
   ansible [core 2.14.5]
   config file = /home/max/vagrant/ansible.cfg
   configured module search path = ['/home/max/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
   ansible python module location = /usr/lib/python3/dist-packages/ansible
   ansible collection location = /home/max/.ansible/collections:/usr/share/ansible/collections
   executable location = /usr/bin/ansible
   python version = 3.10.6 (main, Mar 10 2023, 10:55:28) [GCC 11.3.0] (/usr/bin/python3)
   jinja version = 3.0.3
   libyaml = True
 - Terraform  
   max@max:~/vagrant$ terraform --version
   Terraform v1.4.6
   on linux_amd64  

Задача 4  
  
  Воспроизведите практическую часть лекции самостоятельно.  
  
  Создайте виртуальную машину.  
  Зайдите внутрь ВМ, убедитесь, что Docker установлен с помощью команды 
  Создаем машину:  
  max@max:~/vagrant$ vagrant up  
 Bringing machine 'server1.netology' up with 'virtualbox' provider...  
==> server1.netology: Clearing any previously set forwarded ports...  
==> server1.netology: Clearing any previously set network interfaces...  
==> server1.netology: Preparing network interfaces based on configuration...  
    server1.netology: Adapter 1: nat  
    server1.netology: Adapter 2: hostonly  
==> server1.netology: Forwarding ports...  
    server1.netology: 22 (guest) => 20011 (host) (adapter 1)  
    server1.netology: 22 (guest) => 2222 (host) (adapter 1)  
==> server1.netology: Running 'pre-boot' VM customizations...  
==> server1.netology: Booting VM...  
==> server1.netology: Waiting for machine to boot. This may take a few minutes...  
    server1.netology: SSH address: 127.0.0.1:2222  
    server1.netology: SSH username: vagrant  
    server1.netology: SSH auth method: private key  
    server1.netology: Warning: Remote connection disconnect. Retrying...  
==> server1.netology: Machine booted and ready!  
==> server1.netology: Checking for guest additions in VM...  
    server1.netology: The guest additions on this VM do not match the installed version of  
    server1.netology: VirtualBox! In most cases this is fine, but in rare cases it can  
    server1.netology: prevent things such as shared folders from working properly. If you see  
    server1.netology: shared folder errors, please make sure the guest additions within the  
    server1.netology: virtual machine match the version of VirtualBox you have installed on  
    server1.netology: your host and reload your VM.  
    server1.netology:  
    server1.netology: Guest Additions Version: 7.0.6 r155176  
    server1.netology: VirtualBox Version: 6.1  
==> server1.netology: Setting hostname...  
==> server1.netology: Configuring and enabling network interfaces...  
==> server1.netology: Machine already provisioned. Run `vagrant provision` or use the `--provision`  
==> server1.netology: flag to force provisioning. Provisioners marked to run always will still run.  
max@max:~/vagrant$ vagrant provision  
==> server1.netology: Running provisioner: ansible...  
    server1.netology: Running ansible-playbook...  
  
PLAY [nodes] *******************************************************************  
  
TASK [Gathering Facts] *********************************************************  
ok: [server1.netology]  
  
TASK [Create directory for ssh-keys] *******************************************  
ok: [server1.netology]  
  
TASK [Adding rsa-key in /root/.ssh/authorized_keys] ****************************  
An exception occurred during task execution. To see the full traceback, use -vvv. The error was: If you are using a module and expect the file to exist on the remote, see the remote_src option  
fatal: [server1.netology]: FAILED! => {"changed": false, "msg": "Could not find or access '~/.ssh/id_rsa.pub' on the Ansible Controller.\nIf you are using a module and expect the file to exist on the remote, see the remote_src option"}  
...ignoring  
  
TASK [Checking DNS] ************************************************************  
changed: [server1.netology]  
  
TASK [Installing tools] ********************************************************  
ok: [server1.netology] => (item=git)  
ok: [server1.netology] => (item=curl)  
  
TASK [Installing docker] *******************************************************  
changed: [server1.netology]  
  
TASK [Add the current user to docker group] ************************************  
changed: [server1.netology]  
  
PLAY RECAP *********************************************************************  
server1.netology           : ok=7    changed=3    unreachable=0    failed=0    skipped=0    rescued=0    ignored=1  
  
Заходим на VM
max@max:~/vagrant$ vagrant ssh  
Welcome to Ubuntu 20.04.6 LTS (GNU/Linux 5.4.0-144-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Tue 16 May 2023 03:26:21 AM UTC

  System load:  0.09               Users logged in:          1
  Usage of /:   13.8% of 30.34GB   IPv4 address for docker0: 172.17.0.1
  Memory usage: 26%                IPv4 address for eth0:    10.0.2.15
  Swap usage:   0%                 IPv4 address for eth1:    192.168.56.11
  Processes:    137

 * Introducing Expanded Security Maintenance for Applications.
   Receive updates to over 25,000 software packages with your
   Ubuntu Pro subscription. Free for personal use.

     https://ubuntu.com/pro


This system is built by the Bento project by Chef Software
More information can be found at https://github.com/chef/bento
Last login: Tue May 16 03:24:01 2023  
vagrant@server1:~$ docker ps  
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
