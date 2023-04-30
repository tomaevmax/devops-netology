# devops-netology
# /terraform/.gitifnore
Будут игнорироваться скрытые директории .terraform во всех каталагох
Будут игнорироваться файлы содержащие с расширение или содержащими в имени .tfstate
Будут игнорироваться краш лог файлы crash.log и crash.*.log
Будут игнорироваться файлы содержащие в расширение или в имени *.tfvars и *.tfvars.json
Будут игнорироваться файлы переопределения:
override.tf
override.tf.json
*_override.tf
*_override.tf.json
Будут игнорироваться конфигурацию файлы в текущей директории с именами:
.terraformrc
terraform.rc