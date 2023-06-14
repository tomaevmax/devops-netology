module "test-vm" {
  source          = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
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
  vpc_name     = "develop"
  default_zone = "ru-central1-a"
  default_cidr = ["10.0.1.0/24"]
}

#Пример передачи cloud-config в ВМ для демонстрации №3
data "template_file" "cloudinit" {
 template = file("./cloud-init.yml")
  vars = {
    ssh_public_key     = var.vms_ssh_root_key
  }
}

