output "s3_pic_url" {
  value = "https://storage.yandexcloud.net/${yandex_storage_bucket.s3-bucket.bucket}/${yandex_storage_object.s3-pic.key}"
}
output "kms" {
  value = yandex_kms_symmetric_key.key-s3.id
}