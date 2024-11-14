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
    protocol          = var.vpc-sec-gr-port-proto[2]
    port              = var.vpc-sec-gr-port-proto[0]
    security_group_id = yandex_vpc_security_group.nat-instance.id
  }
}
resource "yandex_vpc_security_group" "k8s-main-sg" {
  name        = "k8s-main-sg"
  description = "Правила группы обеспечивают базовую работоспособность кластера. Примените ее к кластеру и группам узлов."
  network_id  = yandex_vpc_network.vcod.id
  ingress {
    protocol          = "TCP"
    description       = "Правило разрешает проверки доступности с диапазона адресов балансировщика нагрузки. Нужно для работы отказоустойчивого кластера и сервисов балансировщика."
    predefined_target = "loadbalancer_healthchecks"
    from_port         = 0
    to_port           = 65535
  }
  ingress {
    protocol          = "ANY"
    description       = "Правило разрешает взаимодействие мастер-узел и узел-узел внутри группы безопасности."
    predefined_target = "self_security_group"
    from_port         = 0
    to_port           = 65535
  }
  ingress {
    protocol       = "ANY"
    description    = "Правило разрешает взаимодействие под-под и сервис-сервис."
    v4_cidr_blocks = ["10.96.0.0/16", "10.200.0.0/16"]
    from_port      = 0
    to_port        = 65535
  }
  ingress {
    protocol       = "ICMP"
    description    = "Правило разрешает отладочные ICMP-пакеты из внутренних подсетей."
    v4_cidr_blocks = ["192.168.10.0/24", "192.168.20.0/24", "192.168.30.0/24", "192.168.40.0/24", "192.168.50.0/24", "192.168.60.0/24"]
  }
  egress {
    protocol       = "ANY"
    description    = "Правило разрешает весь исходящий трафик."
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }
}

resource "yandex_vpc_security_group" "k8s-public-services" {
  name        = "k8s-public-services"
  description = "Правила группы разрешают подключение к сервисам из интернета. Примените правила только для групп узлов."
  network_id  = yandex_vpc_network.vcod.id

  ingress {
    protocol       = "TCP"
    description    = "Правило разрешает входящий трафик из интернета на диапазон портов NodePort. Добавьте или измените порты на нужные вам."
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 30000
    to_port        = 32767
  }
}

resource "yandex_vpc_security_group" "k8s-nodes-ssh-access" {
  name        = "k8s-nodes-ssh-access"
  description = "Правила группы разрешают подключение к узлам кластера по SSH. Примените правила только для групп узлов."
  network_id  =  yandex_vpc_network.vcod.id
  ingress {
    protocol       = "TCP"
    description    = "Правило разрешает подключение к узлам по SSH с указанных IP-адресов."
    v4_cidr_blocks = ["94.180.3.246/32", "109.107.178.157/32", "193.57.136.103/32"]
    port           = 22
  }
}

resource "yandex_vpc_security_group" "k8s-master-whitelist" {
  name        = "k8s-master-whitelist"
  description = "Правила группы разрешают доступ к API Kubernetes из интернета. Примените правила только к кластеру."
  network_id  = yandex_vpc_network.vcod.id

  ingress {
    protocol       = "TCP"
    description    = "Правило разрешает подключение к API Kubernetes через порт 6443 из указанной сети."
    v4_cidr_blocks = ["94.180.3.246/32", "109.107.178.157/32", "193.57.136.103/32"]
    port           = 6443
  }

  ingress {
    protocol       = "TCP"
    description    = "Правило разрешает подключение к API Kubernetes через порт 443 из указанной сети."
    v4_cidr_blocks = ["94.180.3.246/32", "109.107.178.157/32", "193.57.136.103/32"]
    port           = 443
  }
}
#___________________________________________________
