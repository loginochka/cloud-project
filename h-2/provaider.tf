#___________Provider_________________________________
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}
provider "yandex" {
  zone      = "ru-central1-a"
  token     = var.token
  cloud_id  = var.cloud
  folder_id = var.folder
}
#____________________________________________________
