output "platform_external_ip_address" {
  value = yandex_compute_instance.platform.network_interface[0].nat_ip_address
}

output "database_external_ip_address" {
  value = yandex_compute_instance.database.network_interface[0].nat_ip_address
}
