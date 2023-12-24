resource "yandex_vpc_network" "cloud" {
  name = "cloud-network"
}

resource "yandex_vpc_subnet" "public-a" {
  name = "public-a"
  v4_cidr_blocks = ["192.168.10.0/24"]
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.cloud.id}"
}

resource "yandex_vpc_subnet" "public-b" {
  name = "public-b"
  v4_cidr_blocks = ["192.168.40.0/24"]
  zone           = "ru-central1-b"
  network_id     = "${yandex_vpc_network.cloud.id}"
}

resource "yandex_vpc_subnet" "public-c" {
  name = "public-c"
  v4_cidr_blocks = ["192.168.50.0/24"]
  zone           = "ru-central1-c"
  network_id     = "${yandex_vpc_network.cloud.id}"
}

resource "yandex_vpc_subnet" "privat-a" {
  name = "privat-a"
  v4_cidr_blocks = ["192.168.20.0/24"]
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.cloud.id}"
}

resource "yandex_vpc_subnet" "privat-b" {
  name           = "privat-b"
  v4_cidr_blocks = ["192.168.30.0/24"]
  zone           = "ru-central1-b"
  network_id     = "${yandex_vpc_network.cloud.id}"
}

resource "yandex_vpc_subnet" "privat-c" {
  name           = "privat-c"
  v4_cidr_blocks = ["192.168.60.0/24"]
  zone           = "ru-central1-c"
  network_id     = "${yandex_vpc_network.cloud.id}"
}

resource "yandex_mdb_mysql_cluster" "test-mysql" {
  name        = "test"
  environment = "PRESTABLE"
  network_id  = yandex_vpc_network.cloud.id
  version     = "8.0"
  deletion_protection = false

  resources {
    resource_preset_id = "b1.medium"
    disk_type_id       = "network-ssd"
    disk_size          = 20
  }

  maintenance_window {
    type = "ANYTIME"
  }
  backup_window_start {
    hours = 23
    minutes = 59
  }

  host {
    name      = "master"
    assign_public_ip = true
    zone      = yandex_vpc_subnet.privat-a.zone
    subnet_id = yandex_vpc_subnet.privat-a.id
  }
  host {
    name      = "slave"
    replication_source_name = "master"
    priority        = 10
    zone      = yandex_vpc_subnet.privat-b.zone
    subnet_id = yandex_vpc_subnet.privat-b.id
  }
  host {
    name      = "slave1"
    replication_source_name = "master"
    priority        = 5
    zone      = yandex_vpc_subnet.privat-c.zone
    subnet_id = yandex_vpc_subnet.privat-c.id
  }
}

resource "yandex_mdb_mysql_database" "mydb" {
  cluster_id = yandex_mdb_mysql_cluster.test-mysql.id
  name       = "netology_db"
}

resource "yandex_mdb_mysql_user" "admin" {
  cluster_id = yandex_mdb_mysql_cluster.test-mysql.id
  name       = "netology"
  password   = var.pass_db
  permission {
    database_name = "netology_db"
    roles         = ["ALL"]
  }
}

# Создаем кластер кубернетеса

resource "yandex_iam_service_account" "test-k8s" {
  name        = "k8s-admin"
  description = "K8S regional service account"
}

resource "yandex_resourcemanager_folder_iam_member" "k8s-clusters-agent" {
  # Сервисному аккаунту назначается роль "k8s.clusters.agent".
  folder_id = var.folder_id
  role      = "k8s.clusters.agent"
  member    = "serviceAccount:${yandex_iam_service_account.test-k8s.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "vpc-public-admin" {
  # Сервисному аккаунту назначается роль "vpc.publicAdmin".
  folder_id = var.folder_id
  role      = "vpc.publicAdmin"
  member    = "serviceAccount:${yandex_iam_service_account.test-k8s.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "images-puller" {
  # Сервисному аккаунту назначается роль "container-registry.images.puller".
  folder_id = var.folder_id
  role      = "container-registry.images.puller"
  member    = "serviceAccount:${yandex_iam_service_account.test-k8s.id}"
}

resource "yandex_kms_symmetric_key" "kms-key" {
  # Ключ для шифрования важной информации, такой как пароли, OAuth-токены и SSH-ключи.
  name              = "kms-key"
  default_algorithm = "AES_128"
  rotation_period   = "8760h" # 1 год.
}

resource "yandex_resourcemanager_folder_iam_member" "viewer" {
  folder_id = var.folder_id
  role      = "viewer"
  member    = "serviceAccount:${yandex_iam_service_account.test-k8s.id}"
}

resource "yandex_vpc_security_group" "k8s-main-sg" {
  name        = "k8s-main-sg"
  description = "Правила группы обеспечивают базовую работоспособность кластера Managed Service for Kubernetes. Примените ее к кластеру Managed Service for Kubernetes и группам узлов."
  network_id  = yandex_vpc_network.cloud.id
  ingress {
    protocol          = "TCP"
    description       = "Правило разрешает проверки доступности с диапазона адресов балансировщика нагрузки. Нужно для работы отказоустойчивого кластера Managed Service for Kubernetes и сервисов балансировщика."
    predefined_target = "loadbalancer_healthchecks"
    from_port         = 0
    to_port           = 65535
  }
  ingress {
    protocol          = "ANY"
    description       = "Правило разрешает взаимодействие мастер-узел и узел-узел внутри группы безопасности."
    predefined_target = "self_security_group"
    from_port         = 0
    to_port           = 65535
  }
  ingress {
    protocol          = "ANY"
    description       = "Правило разрешает взаимодействие под-под и сервис-сервис. Укажите подсети вашего кластера Managed Service for Kubernetes и сервисов."
    v4_cidr_blocks    = concat(yandex_vpc_subnet.public-a.v4_cidr_blocks, yandex_vpc_subnet.public-b.v4_cidr_blocks,yandex_vpc_subnet.public-c.v4_cidr_blocks)
    from_port         = 0
    to_port           = 65535
  }
  ingress {
    protocol          = "ICMP"
    description       = "Правило разрешает отладочные ICMP-пакеты из внутренних подсетей."
    v4_cidr_blocks    = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
  }
  ingress {
    protocol          = "TCP"
    description       = "Правило разрешает входящий трафик из интернета на диапазон портов NodePort. Добавьте или измените порты на нужные вам."
    v4_cidr_blocks    = ["0.0.0.0/0"]
    from_port         = 30000
    to_port           = 32767
  }
  egress {
    protocol          = "ANY"
    description       = "Правило разрешает весь исходящий трафик. Узлы могут связаться с Yandex Container Registry, Yandex Object Storage, Docker Hub и т. д."
    v4_cidr_blocks    = ["0.0.0.0/0"]
    from_port         = 0
    to_port           = 65535
  }
}

resource "yandex_vpc_security_group" "k8s-master-whitelist" {
  name        = "k8s-master-whitelist"
  description = "Правила группы разрешают доступ к API Kubernetes из интернета. Примените правила только к кластеру."
  network_id  = yandex_vpc_network.cloud.id

  ingress {
    protocol       = "TCP"
    description    = "Правило разрешает подключение к API Kubernetes через порт 6443 из указанной сети."
    v4_cidr_blocks = ["109.248.252.157/32"]
    port           = 6443
  }

  ingress {
    protocol       = "TCP"
    description    = "Правило разрешает подключение к API Kubernetes через порт 443 из указанной сети."
    v4_cidr_blocks = ["109.248.252.157/32"]
    port           = 443
  }
}

resource "yandex_kubernetes_cluster" "k8s-regional" {
  network_id = yandex_vpc_network.cloud.id
  release_channel = "STABLE"
  master {
    version = var.k8s_version
    public_ip = true
    regional {
      region = "ru-central1"
      location {
        zone      = yandex_vpc_subnet.public-a.zone
        subnet_id = yandex_vpc_subnet.public-a.id
      }
      location {
        zone      = yandex_vpc_subnet.public-b.zone
        subnet_id = yandex_vpc_subnet.public-b.id
      }
      location {
        zone      = yandex_vpc_subnet.public-c.zone
        subnet_id = yandex_vpc_subnet.public-c.id
      }
    }
    security_group_ids = [yandex_vpc_security_group.k8s-main-sg.id,yandex_vpc_security_group.k8s-master-whitelist.id]
  }
  service_account_id      = yandex_iam_service_account.test-k8s.id
  node_service_account_id = yandex_iam_service_account.test-k8s.id
  depends_on = [
    yandex_resourcemanager_folder_iam_member.k8s-clusters-agent,
    yandex_resourcemanager_folder_iam_member.vpc-public-admin,
    yandex_resourcemanager_folder_iam_member.images-puller
  ]
  kms_provider {
    key_id = yandex_kms_symmetric_key.kms-key.id
  }
}

resource "yandex_kubernetes_node_group" "worker-node" {
  cluster_id = yandex_kubernetes_cluster.k8s-regional.id
  name       = "worker-node-netology"

  instance_template {
    name                      = "regional-{instance.short_id}-{instance_group.id}"
    platform_id               = "standard-v1"
    network_acceleration_type = "standard"
    container_runtime {
      type = "containerd"
    }

    resources {
      memory = 4
      cores  = 2
    }

    boot_disk {
      type = "network-hdd"
      size = 40
    }
  }
  scale_policy {
    fixed_scale {
      size = 3
    }
  }
  allocation_policy {
    location {
      zone = yandex_vpc_subnet.public-a.zone
      subnet_id = yandex_vpc_subnet.public-a.id
    }
    location {
      zone = yandex_vpc_subnet.public-b.zone
      subnet_id = yandex_vpc_subnet.public-b.id
    }
    location {
      zone = yandex_vpc_subnet.public-c.zone
      subnet_id = yandex_vpc_subnet.public-c.id
    }
  }
}