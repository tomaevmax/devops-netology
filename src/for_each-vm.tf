variable "resource" {
  description = "List of VMs with specified parameters"
  type = list(object({
    vm_name = string
    cpu  = number
    ram  = number
    disk = number
  }))
  default = [
    {
      vm_name = "main"
      cpu     = 2
      ram     = 2
      disk    = 10
    },
    {
      vm_name = "replica"
      cpu     = 2
      ram     = 2
      disk    = 5
    }
  ]
}
resource "yandex_compute_instance" "test_for" {
  for_each = {
    0 = "main"
    1 = "replica"
  }
  name        = "netology-develop-platform-web-${each.value}"
  platform_id = "standard-v1"


  resources {
    cores  = var.resource["${each.key}"].cpu
    memory = var.resource["${each.key}"].ram
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2004-lts.image_id
      type = "network-hdd"
      size = var.resource["${each.key}"].disk
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
  depends_on = [
    yandex_compute_instance.example
  ]
}