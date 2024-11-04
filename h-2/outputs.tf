# output "NAT-instance-ip" {
#   value = yandex_compute_instance.vm-public["main"].network_interface[0].nat_ip_address  
# }
# output "private-vm-ip" {
#   value = yandex_compute_instance.vm-private["main"].network_interface[0].ip_address  
# }
output "s3_pic_url" {
  value = "https://storage.yandexcloud.net/${yandex_storage_bucket.s3-bucket.bucket}/${yandex_storage_object.s3-pic.key}"
}
output "nlb-external-ip" {
  value = [for l in yandex_lb_network_load_balancer.lamp-lb.listener : 
    (length(l.external_address_spec) > 0 ? tolist([for e in l.external_address_spec : e.address])[0] : null)
  ][0]
}





