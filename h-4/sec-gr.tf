#___________Security Group____________________________
resource "yandex_vpc_security_group" "nat-instance" {
  name       = var.vpc-sec-gr-name[0]
  network_id = yandex_vpc_network.vcod.id

  egress {
    protocol       = var.vpc-sec-gr-port-proto[1]
    v4_cidr_blocks = [var.vpc-sec-gr-ip[0]]
  }

  ingress {
    protocol       = var.vpc-sec-gr-port-proto[2]
    v4_cidr_blocks = [var.vpc-sec-gr-ip[0]]
    port           = var.vpc-sec-gr-port-proto[0]
  }
}
resource "yandex_vpc_security_group" "MySQL" {
  name       = var.vpc-sec-gr-name[1]
  network_id = yandex_vpc_network.vcod.id

  egress {
    protocol       = var.vpc-sec-gr-port-proto[1]
    v4_cidr_blocks = [var.vpc-sec-gr-ip[0]]
  }
  ingress {
    protocol       = var.vpc-sec-gr-port-proto[2]
    v4_cidr_blocks = [var.vpc-sec-gr-ip[0]]
    port           = var.vpc-sec-gr-port-proto[4]
  }
  ingress {
    protocol = var.vpc-sec-gr-port-proto[2]
    port = var.vpc-sec-gr-port-proto[0]
    security_group_id = yandex_vpc_security_group.nat-instance.id
  }
}
#___________________________________________________
