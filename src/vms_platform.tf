variable "vm_web_resources" {
  type = map
  default 	= {
    cores = 2
    memory = 1
    fraction = 5
  }
}

variable "vm_db_resources" {
  type = map
  default 	= {
    cores = 2
    memory = 2
    fraction = 20
  }
}

variable  "vm_platform_id" {
  type        = string
  default = "standard-v1"
}

variable  "vm_scheduling_policy" {
  type        = bool
  default = true
}

variable  "vm_network_interface_nat" {
  type        = bool
  default = true
}

variable "vm_metadata_resources" {
  type = map(object({ serial-port-enable = number, ssh-keys = string}))
  default 	= {
    "metadata" = {
    serial-port-enable = 1
    ssh-keys = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILzsVjG95NO8uNUlNLhJBXzg75lhffQcZpaqRpchSglS"
    }
  }
}
