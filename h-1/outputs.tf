output "NAT-instance-ip" {
  value = yandex_compute_instance.vm-public["main"].network_interface[0].nat_ip_address  
}
output "private-vm-ip" {
  value = yandex_compute_instance.vm-private["main"].network_interface[0].ip_address  
}
