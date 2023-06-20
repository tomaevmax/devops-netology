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

Возьмите ваш GitHub репозиторий с выполненным ДЗ №4 в ветке 'terraform-04' и сделайте из него ветку 'terraform-05'
Повторите демонстрацию лекции: настройте YDB, S3 bucket, yandex service account, права доступа и мигрируйте State проекта в S3 с блокировками. Предоставьте скриншоты процесса в качестве ответа.
Закомитьте в ветку 'terraform-05' все изменения.
Откройте в проекте terraform console, а в другом окне из этой же директории попробуйте запустить terraform apply.
Пришлите ответ об ошибке доступа к State.
Принудительно разблокируйте State. Пришлите команду и вывод.

Ответ:    
Создаем bucket   
![Снимок экрана 2023-06-19 в 06 18 02](https://github.com/tomaevmax/devops-netology/assets/32243921/865dd8d1-6683-40e8-a9c0-083662d9e231)   
Создаем ydb   
![Снимок экрана 2023-06-19 в 06 20 38](https://github.com/tomaevmax/devops-netology/assets/32243921/fd963647-5675-4aa0-9280-4e566ce2900c)   
Создаем таблицу   
![Снимок экрана 2023-06-19 в 06 25 49](https://github.com/tomaevmax/devops-netology/assets/32243921/99382274-ba96-4805-92a6-b5fc4185accf)   
Выдаем права сервисному аккаунту  
![Снимок экрана 2023-06-19 в 06 41 18](https://github.com/tomaevmax/devops-netology/assets/32243921/e5c46f14-2010-4de2-9a96-2cb8719806d8)   
Выдаем права сервисному аккаунту  
![Снимок экрана 2023-06-19 в 06 48 02](https://github.com/tomaevmax/devops-netology/assets/32243921/25f497ab-3dd4-456e-bb9a-1fc6cadd562a)   
Мигрируем state в S3   
![Снимок экрана 2023-06-19 в 07 00 43](https://github.com/tomaevmax/devops-netology/assets/32243921/5d0f48f6-fdd2-4198-a3d9-f73614498806)   
Попытка запуска terraform apply после миграции в S3   
![Снимок экрана 2023-06-19 в 07 00 30](https://github.com/tomaevmax/devops-netology/assets/32243921/2172b9d0-6e87-42c2-a14b-d662d689a16e)   
Принудительно разблокируем state   
![Снимок экрана 2023-06-19 в 07 18 11](https://github.com/tomaevmax/devops-netology/assets/32243921/ec63d24f-310e-4d7b-b551-c120d91028d1)   

## Задача 3   

Сделайте в GitHub из ветки 'terraform-05' новую ветку 'terraform-hotfix'.
Проверье код с помощью tflint и checkov, исправьте все предупреждения и ошибки в 'terraform-hotfix', сделайте комит.
Откройте новый pull request 'terraform-hotfix' --> 'terraform-05'.
Вставьте в комментарий PR результат анализа tflint и checkov, план изменений инфраструктуры из вывода команды terraform plan.
Пришлите ссылку на PR для ревью(вливать код в 'terraform-05' не нужно).

Ответ:    

[Pull request]([/src/modules/vpc_dev/docs.md](https://github.com/tomaevmax/devops-netology/pull/1))   
