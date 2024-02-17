terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }

  backend "s3" {
    endpoint ="https://storage.yandexcloud.net"
    bucket = "netology-devops22"
    region = "ru-central1"
    key    = "tf/tf.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true

  }
}

provider "yandex" {
  folder_id = local.folder_id
  service_account_key_file = "key.json"
}

resource "yandex_iam_service_account" "sa" {
  name = local.sa_name
}

// Assigning roles to the service account
resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
  folder_id = local.folder_id
  role      = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

// Creating a static access key
resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "static access key for object storage"
}
