resource "yandex_compute_disk" "dynamic-hdd" {
  count = 3
  name       = "disk-${count.index}"
  type       = "network-hdd"
  zone       =  var.default_zone
  size       = 1
}

resource "yandex_compute_instance" "dinamic-disks" {
  name        = "netology-develop-platform-web-storage"
  platform_id = "standard-v1"

  resources {
    cores         = 2
    memory        = 1
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2004-lts.image_id
      type     = "network-hdd"
      size     = 10
    }
  }
  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.dynamic-hdd
    content {
      disk_id     = yandex_compute_disk.dynamic-hdd[secondary_disk.key].id
      auto_delete = true
    }
  }
  metadata = {
    ssh-keys = "ubuntu:${local.key}"
  }

  scheduling_policy { preemptible = true }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }
  allow_stopping_for_update = true
}