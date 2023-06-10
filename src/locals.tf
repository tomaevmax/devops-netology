locals {
  name_web= "${var.vm_web_name}"
  name_db= "${var.vm_db_name}"
  key= file("~/.ssh/id_ed25519.pub")
}