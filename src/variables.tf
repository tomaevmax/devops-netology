###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "admin_id" {
  type        = string
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "pass_db" {
  type        = string
  default     = "https://storage.yandexcloud.net/cloud-dz2-picture/test.png"
}

variable "k8s_version" {
  type        = string
  default     = "https://storage.yandexcloud.net/cloud-dz2-picture/test.png"
}
