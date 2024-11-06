# output "NAT-instance-ip" {
#   value = yandex_compute_instance.vm-public["main"].network_interface[0].nat_ip_address  
# }
# output "private-vm-ip" {
#   value = yandex_compute_instance.vm-private["main"].network_interface[0].ip_address  
# }
output "s3_pic_url" {
  value = "https://storage.yandexcloud.net/${yandex_storage_bucket.s3-bucket.bucket}/${yandex_storage_object.s3-pic.key}"
}
# output "nlb-external-ip-1" {
#   value = yandex_lb_network_load_balancer.lamp-lb.listener.*.external_address_spec[0].*.address
# }
output "alb" {
  value = yandex_alb_load_balancer.alb-balancer.listener[0].endpoint[0].address[0].external_ipv4_address[0].address
}