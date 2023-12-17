resource "yandex_vpc_network" "cloud" {
  name = "cloud-network"
}

resource "yandex_vpc_subnet" "public" {
  name = "public"
  v4_cidr_blocks = ["192.168.10.0/24"]
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.cloud.id}"
}

resource "yandex_iam_service_account" "sa" {
  name = "downloader"
}

// Назначение роли сервисному аккаунту
resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
  folder_id = var.folder_id
  role      = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

// Создание статического ключа доступа
resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "static access key for object storage"
}

// Создание бакета с использованием ключа
resource "yandex_storage_bucket" "cloud-dz2" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = "cloud-dz2-picture"
  force_destroy = "true"
  max_size = 1073741824
}

resource "yandex_storage_object" "image-object" {
  access_key = yandex_storage_bucket.cloud-dz2.access_key
  secret_key = yandex_storage_bucket.cloud-dz2.secret_key
  acl        = "public-read"
  bucket     = "cloud-dz2-picture"
  key        = "test.png"
  source     = "/Users/maksimtomaev/Downloads/test.png"
  depends_on = [
    yandex_storage_bucket.cloud-dz2,
  ]
}

resource "yandex_compute_image" "lamp-vm-image" {
  source_family = "lamp"
}

resource "yandex_compute_instance_group" "lamp-group" {
  name                = "lamp-server"
  folder_id           = var.folder_id
  service_account_id  =  var.admin_id
  deletion_protection = false
  instance_template {
    platform_id = "standard-v1"
    resources {
      memory = 2
      cores  = 2
    }
    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = yandex_compute_image.lamp-vm-image.id
        size     = 4
      }
    }
    network_interface {
      network_id = "${yandex_vpc_network.cloud.id}"
      subnet_ids = ["${yandex_vpc_subnet.public.id}"]
      nat = "true"
    }
    metadata = {
      user-data = "#cloud-config\nusers:\n  - name: ubuntu\n    groups: sudo,wheel\n    shell: /bin/bash\n    sudo: ['ALL=(ALL) NOPASSWD:ALL']\n    ssh-authorized-keys:\n      - ${file("~/.ssh/id_ed25519.pub")}runcmd:\n  - echo '<html><head><title>Test image</title></head><body><img src=${var.image_id}></body></html>' > /var/www/html/index.html"
    }
    network_settings {
      type = "STANDARD"
    }
  }

  scale_policy {
    fixed_scale {
      size = 3
    }
  }

  allocation_policy {
    zones = ["ru-central1-a"]
  }

  deploy_policy {
    max_unavailable = 3
    max_creating    = 3
    max_expansion   = 3
    max_deleting    = 3
  }

  health_check {
    interval = 60
    timeout = 30
    http_options {
      port = 80
      path = "/index.html"
    }
  }
  load_balancer {
    target_group_name        = "lamp-server"
    target_group_description = "test balanser"
  }
}

resource "yandex_lb_network_load_balancer" "test-lb" {
  name = "network-load-balancer-1"

  listener {
    name = "network-load-balancer-1-listener"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_compute_instance_group.lamp-group.load_balancer.0.target_group_id

    healthcheck {
      name = "http"
      http_options {
        port = 80
        path = "/index.html"
      }
    }
  }
}