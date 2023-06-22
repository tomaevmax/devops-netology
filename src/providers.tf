terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = ">= 0.92.0"
    }
    template = "~> 2.0"
  }
  required_version = ">=0.13"
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
}
