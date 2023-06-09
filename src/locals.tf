locals {
  env= "develop"
  project= "platform"
  role_db= "db"
  role_veb= "web"
  name_web= "netoloy-${local.env}-${local.project}-${local.role_veb}"
  name_db= "netoloy-${local.env}-${local.project}-${local.role_db}"
}
