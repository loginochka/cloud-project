resource "yandex_storage_bucket" "s3-bucket" {
  bucket                = var.s3-name
  folder_id             = var.folder
  max_size              = var.s3-max-size
  default_storage_class = var.s3-class[0]
  anonymous_access_flags {
    read        = var.s3-access-flag[0]
    list        = var.s3-access-flag[0]
    config_read = var.s3-access-flag[1]
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "aws:kms"
        kms_master_key_id = yandex_kms_symmetric_key.key-s3.id
      }
    }
  }
}
resource "yandex_storage_object" "s3-pic" {
  bucket       = yandex_storage_bucket.s3-bucket.id
  key          = var.s3-key
  source       = var.s3-pic-path
  acl          = var.s3-acl[1]
  content_type = var.s3-content-type
}
