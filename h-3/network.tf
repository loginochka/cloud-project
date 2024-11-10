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
#_____________________________________________________

