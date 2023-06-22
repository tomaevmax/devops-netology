module "test-vm" {
  source          = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=test"
  env_name        = "develop"
  network_id      =  module.vpc_dev.vpc_id
  subnet_zones    = ["ru-central1-a"]
  subnet_ids      =  [module.vpc_dev.subnet_id]
  instance_name   = "web"
  instance_count  = 2
  image_family    = "ubuntu-2004-lts"
  public_ip       = true

  metadata = {
      user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
      serial-port-enable = 1
  }
}

module "vpc_dev" {
  source       = "./modules/vpc_dev"
  vpc_name     = var.vpc_name
  default_zone = var.default_zone
  default_cidr = var.default_cidr
}

#Пример передачи cloud-config в ВМ для демонстрации №3
data "template_file" "cloudinit" {
 template = file("./cloud-init.yml")
  vars = {
    ssh_public_key     = var.vms_ssh_root_key
  }
}

terraform {
  backend "s3" {
    endpoint                    = "storage.yandexcloud.net"
    bucket                      = "tfstate-develop05"
    region                      = "ru-central1"
    key                         = "terraform.tfstate"
    skip_region_validation      = true
    skip_credentials_validation = true
    dynamodb_endpoint           = "https://docapi.serverless.yandexcloud.net/ru-central1/b1geg4s73ugdcad9uvhs/etn5c5hqs9foeckv3pev"
    dynamodb_table              = "tfstate-lock-develop"
  }
}
