# Домашнее задание к занятию "Использование Terraform в команде  

## Задача 1   

Возьмите код:
из ДЗ к лекции №04
из демо к лекции №04.
Проверьте код с помощью tflint и checkov. Вам не нужно инициализировать этот проект.
Перечислите какие типы ошибок обнаружены в проекте (без дублей).   

Ответ:    
```   
4 issue(s) found:

Warning: Missing version constraint for provider "yandex" in "required_providers" (terraform_required_providers)

  on providers.tf line 10:
  10: provider "yandex" {

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.2.2/docs/rules/terraform_required_providers.md

Warning: variable "vms_ssh_root_key" is declared but not used (terraform_unused_declarations)

  on variables.tf line 36:
  36: variable "vms_ssh_root_key" {

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.2.2/docs/rules/terraform_unused_declarations.md

Warning: variable "vm_web_name" is declared but not used (terraform_unused_declarations)

  on variables.tf line 43:
  43: variable "vm_web_name" {

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.2.2/docs/rules/terraform_unused_declarations.md

Warning: variable "vm_db_name" is declared but not used (terraform_unused_declarations)

  on variables.tf line 50:
  50: variable "vm_db_name" {

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.2.2/docs/rules/terraform_unused_declarations.md

demo

6 issue(s) found:

Warning: Missing version constraint for provider "yandex" in "required_providers" (terraform_required_providers)

  on main.tf line 25:
  25: resource "yandex_vpc_subnet" "develop" {

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.2.2/docs/rules/terraform_required_providers.md

Warning: Module source "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main" uses a default branch as ref (main) (terraform_module_pinned_source)

  on main.tf line 33:
  33:   source          = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.2.2/docs/rules/terraform_module_pinned_source.md

Warning: Missing version constraint for provider "template" in "required_providers" (terraform_required_providers)

  on main.tf line 51:
  51: data "template_file" "cloudinit" {

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.2.2/docs/rules/terraform_required_providers.md

Warning: variable "default_cidr" is declared but not used (terraform_unused_declarations)

  on variables.tf line 22:
  22: variable "default_cidr" {

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.2.2/docs/rules/terraform_unused_declarations.md

Warning: variable "vpc_name" is declared but not used (terraform_unused_declarations)

  on variables.tf line 28:
  28: variable "vpc_name" {

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.2.2/docs/rules/terraform_unused_declarations.md

Warning: variable "public_key" is declared but not used (terraform_unused_declarations)

  on variables.tf line 34:
  34: variable "public_key" {

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.2.2/docs/rules/terraform_unused_declarations.md

 checkov -d .     
2023-06-16 06:58:00,604 [MainThread  ] [WARNI]  Failed to download module git::https://github.com/udjin10/yandex_compute_instance.git?ref=main:None (for external modules, the --download-external-modules flag is required)
[ kubernetes framework ]: 100%|████████████████████|[1/1], Current File Scanned=cloud-init.yml
[ terraform framework ]: 100%|████████████████████|[2/2], Current File Scanned=variables.tf
[ secrets framework ]: 100%|████████████████████|[3/3], Current File Scanned=./variables.tf  
[ ansible framework ]: 100%|████████████████████|[1/1], Current File Scanned=cloud-init.yml


```   


## Задача 2   

Напишите локальный модуль vpc, который будет создавать 2 ресурса: одну сеть и одну подсеть в зоне, объявленной при вызове модуля. например: ru-central1-a.
Модуль должен возвращать значения vpc.id и subnet.id
Замените ресурсы yandex_vpc_network и yandex_vpc_subnet, созданным модулем.
Сгенерируйте документацию к модулю с помощью terraform-docs.   

Ответ:    

[modul](/src/modules/vpc_dev)   
[docs](/src/modules/vpc_dev/docs.md)   


## Задача 3   

Выведите список ресурсов в стейте.  
Удалите из стейта модуль vpc.  
Импортируйте его обратно.   
Проверьте terraform plan - изменений быть не должно.   
Приложите список выполненных команд и вывод.   

Ответ:    

[disk-vm.tf](/src/disk_vm.tf)  
```  
 terraform state list

```   
```  
 terraform state rm 'module.vpc_dev'

```   
```  
 terraform import 'module.vpc_dev.yandex_vpc_network.develop' enpfbes96a495cn0ejn4

```   
```  
 terraform import 'module.vpc_dev.yandex_vpc_subnet.develop' e9b5h9g371tvaubj6ebd 

```  
```  
 terraform plan

```   