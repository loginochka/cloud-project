#___________Security Group____________________________
resource "yandex_vpc_security_group" "security-group" {
  name       = var.vpc-sec-gr-name
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
#___________________________________________________
