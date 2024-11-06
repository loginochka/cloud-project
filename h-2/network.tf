#___________Network__________________________________
resource "yandex_vpc_network" "vcod" {
  name = var.vpc-name
}
resource "yandex_vpc_subnet" "public" {
  name           = var.vpc-sub-name[0]
  zone           = var.vpc-zone-name[0]
  network_id     = yandex_vpc_network.vcod.id
  v4_cidr_blocks = [var.vpc-sub-ip[0]]
}
# resource "yandex_vpc_subnet" "private" {
#   name                          = var.vpc-sub-name[1]
#   zone                          = var.vpc-zone-name[0]
#   network_id                    = yandex_vpc_network.vcod.id
#   v4_cidr_blocks                = [var.vpc-sub-ip[1]]
#   route_table_id                = yandex_vpc_route_table.nat-instance-rt.id
# }
# resource "yandex_vpc_route_table" "nat-instance-rt" {
#   name                          = var.vpc-rt-name
#   network_id                    = yandex_vpc_network.vcod.id
#   static_route {
#     destination_prefix          = var.vpc-rt-prefix[0]
#     next_hop_address            = yandex_compute_instance.vm-public["main"].network_interface.0.ip_address
#   }
# }
#_____________________________________________________

