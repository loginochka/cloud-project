resource "yandex_kms_symmetric_key" "key-k8s" {
  name              = "kms-for-k8s"
  default_algorithm = "AES_128"
  rotation_period   = "8760h"
}