resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}


data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_image
}

resource "yandex_compute_instance" "example" {
  name        = local.name_web
  platform_id = var.vm_platform_id
  resources {
    cores         = var.vm_web_resources.cores
    memory        = var.vm_web_resources.memory
    core_fraction = var.vm_web_resources.fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vm_scheduling_policy
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vm_network_interface_nat
  }

  metadata = {
    serial-port-enable = var.vm_metadata_resources.metadata.serial-port-enable
    ssh-keys           =  var.vm_metadata_resources.metadata.ssh-keys
  }

}

resource "yandex_compute_instance" "database" {
  name        = local.name_db
  platform_id = var.vm_platform_id
  resources {
    cores         = var.vm_db_resources.cores
    memory        = var.vm_db_resources.memory
    core_fraction = var.vm_db_resources.fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vm_scheduling_policy
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vm_network_interface_nat
  }

  metadata = {
    serial-port-enable = var.vm_metadata_resources.metadata.serial-port-enable
    ssh-keys           =  var.vm_metadata_resources.metadata.ssh-keys
  }

}