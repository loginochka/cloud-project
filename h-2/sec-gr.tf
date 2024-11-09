#___________Security Group____________________________
resource "yandex_vpc_security_group" "security-group-lamp" {
  name       = var.vpc-sec-gr-name[1]
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
  ingress {
    protocol       = var.vpc-sec-gr-port-proto[2]
    v4_cidr_blocks = [var.vpc-sec-gr-ip[0]]
    port           = var.vpc-sec-gr-port-proto[3]
  }
}
resource "yandex_vpc_security_group" "alb" {
  network_id = yandex_vpc_network.vcod.id
  name       = "alb-security-group"
  ingress {
    protocol       = var.vpc-sec-gr-port-proto[2]
    port           = var.vpc-sec-gr-port-proto[3]
    v4_cidr_blocks = [var.vpc-sec-gr-ip[0]]
  }
  ingress {
    protocol          = var.vpc-sec-gr-port-proto[2]
    description       = "healthchecks"
    predefined_target = "loadbalancer_healthchecks"
    port              = 30080
  }
  egress {
    protocol       = var.vpc-sec-gr-port-proto[1]
    v4_cidr_blocks = [var.vpc-sec-gr-ip[0]]
  }
}
#___________________________________________________
