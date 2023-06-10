resource "local_file" "hosts_cfg" {
  content = templatefile("${path.module}/hosts.tftpl",
    {
      database =  [yandex_compute_instance.database]
      webservers =  yandex_compute_instance.webservers
      storage =  [yandex_compute_instance.dinamic-disks]
    }
  )
  filename = "${path.module}/hosts.cfg"
}