resource "yandex_kms_symmetric_key" "key-s3" {
  name              = "kms-for-s3"
  default_algorithm = "AES_128"
  rotation_period   = "8760h"
}