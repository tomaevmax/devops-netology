resource "yandex_vpc_network" "cloud" {
  name = "cloud-network"
}

resource "yandex_vpc_subnet" "public" {
  name = "public"
  v4_cidr_blocks = ["192.168.10.0/24"]
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.cloud.id}"
}

resource "yandex_dns_zone" "zone-netology" {
  name        = "tomaevmaxdz3"
  description = "desc"
  zone             = "tomaevmaxdz3.ru."
  public           = true
}

resource "yandex_cm_certificate" "le-certificate" {
  name    = "tomaevmaxdz3"
  domains = ["tomaevmaxdz3.ru"]

  managed {
    challenge_type = "DNS_CNAME"
  }
}

resource "yandex_kms_symmetric_key" "test-key" {
  name              = "test-symetric-key"
  description       = "dz3"
  default_algorithm = "AES_128"
  rotation_period   = "8760h" // equal to 1 year
  lifecycle {
    prevent_destroy = false
  }
}

// Создание статического ключа доступа
resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = var.admin_id
  description        = "static access key for object storage"
}

// Создание бакета с использованием ключа
resource "yandex_storage_bucket" "cloud-dz3" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = "tomaevmaxdz3.ru"
  force_destroy = "true"
  acl           = "public-read"
  max_size = 1073741824
  https {
    certificate_id = yandex_cm_certificate.le-certificate.id
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.test-key.id
        sse_algorithm     = "aws:kms"
      }
    }
  }
  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

resource "yandex_storage_object" "image-object" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  acl        = "public-read"
  bucket     = "tomaevmaxdz3.ru"
  key        = "test.png"
  source     = "/Users/maksimtomaev/Downloads/test.png"
  depends_on = [yandex_storage_bucket.cloud-dz3]
}

resource "yandex_storage_object" "index-html" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  acl        = "public-read"
  bucket     = "tomaevmaxdz3.ru"
  key        = "index.html"
  source     = "/Users/maksimtomaev/Downloads/index.html"
  depends_on = [yandex_storage_bucket.cloud-dz3]
}