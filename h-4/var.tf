#___________________________________________________
variable "token" {
  sensitive = true
}
variable "folder" {
  sensitive = true
}
variable "cloud" {
  sensitive = true
}
variable "svc-name" {
  type    = list(string)
  default = ["lamp-scale"]
}
variable "svc-access" {
  type    = list(string)
  default = ["editor"]
}
#___________Instance________________________________
#___________________________________________________
variable "vm-nat-inst-image-id" {
  type        = string
  default     = "fd8idcndp9uuidms4500"
  description = "ubuntu-2204-nat"
}
variable "vm-nat-ipv4" {
  type    = string
  default = "192.168.10.254"
}
variable "vm-disk-type" {
  type    = list(string)
  default = ["network-hdd", "network-ssd", "network-ssd-nonreplicated", "network-ssd-io-m3"]
}
variable "vm-disk-size" {
  type    = list(string)
  default = ["20"]
}
variable "vm-name" {
  type    = list(string)
  default = ["vm-private", "vm-public", "lamp-inst-group"]
}
variable "vm-platform" {
  type    = string
  default = "standard-v1"
}
variable "vm-zone-name" {
  type    = list(string)
  default = ["ru-central1-a", "ru-central1-b", "ru-central1-d"]
}
variable "vm-hostname" {
  type    = list(string)
  default = ["ubupriv", "ubupub"]
}
variable "vm-del-protect" {
  type    = list(string)
  default = ["true", "false"]
}
variable "vm-hcheck-int" {
  type    = list(string)
  default = ["15"]
}
variable "vm-hcheck-to" {
  type    = list(string)
  default = ["5"]
}
variable "vm-hcheck-threshold" {
  type    = list(string)
  default = ["4", "2"]
}
variable "vm-scale-unavailable" {
  type    = list(string)
  default = ["2"]
}
variable "vm-scale-expansion" {
  type    = list(string)
  default = ["2"]
}
variable "vm-scale-fixed" {
  type    = list(string)
  default = ["3"]
}
variable "vm-hcheck-port" {
  type    = list(string)
  default = ["80", "443"]
}
variable "vm-hcheck-path" {
  type    = list(string)
  default = ["/"]
}
variable "vm-preemptible" {
  type    = list(string)
  default = ["true", "false"]
}
variable "vm-nat-status" {
  type    = list(string)
  default = ["true", "false"]
}
variable "vm-nat-resource" {
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
  }))
  default = {
    main = {
      cores         = 4
      memory        = 4
      core_fraction = 5
    }
  }
}
#___________Load Balancer___________________________
#___________________________________________________
variable "target-group" {
  type    = list(string)
  default = ["target-group-instance-vm"]
}
variable "nlb-name" {
  type    = list(string)
  default = ["nlb-for-lamp"]
}
variable "nlb-zone-name" {
  type    = list(string)
  default = ["ru-central1-a", "ru-central1-b", "ru-central1-d"]
}
variable "nlb-listener-name" {
  type    = list(string)
  default = ["nlb-web-listener"]
}
variable "nlb-listener-port" {
  type    = list(string)
  default = ["80"]
}
variable "nlb-healthcheck-name" {
  type    = list(string)
  default = ["nlb-http-health"]
}
variable "nlb-healthcheck-port" {
  type    = list(string)
  default = ["80"]
}
variable "nlb-healthcheck-path" {
  type    = list(string)
  default = ["/"]
}
#___________VPC_____________________________________
#___________________________________________________
variable "vpc-name" {
  type    = string
  default = "vcod"
}
variable "vpc-sub-name" {
  type    = list(string)
  default = ["public", "private-a", "private-b", "private-d"]
}
variable "vpc-sub-ip" {
  type    = list(string)
  default = ["192.168.10.0/24", "192.168.20.0/24", "192.168.30.0/24", "192.168.40.0/24"]
}
variable "vpc-zone-name" {
  type    = list(string)
  default = ["ru-central1-a", "ru-central1-b", "ru-central1-d"]
}
variable "vpc-rt-name" {
  type    = string
  default = "default-nat-rt"
}
variable "vpc-rt-prefix" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}
variable "vpc-sec-gr-ip" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}
variable "vpc-sec-gr-port-proto" {
  type    = list(string)
  default = ["22", "ANY", "TCP", "80", "3306"]
}
variable "vpc-sec-gr-name" {
  type    = list(string)
  default = ["nat-instance-security-group", "mysql-security-group"]
}
#___________________________________________________
#___________MySQL___________________________________
variable "mysql-user-name" {
  type    = list(string)
  default = ["netology-admin"]
}
variable "mysql-user-password" {
  type      = string
  sensitive = true
}
variable "mysql-db-name" {
  type    = list(string)
  default = ["netology_db"]
}
variable "mysql-cluster-name" {
  type    = string
  default = "netology-mysql-cluster"
}
variable "mysql-zone-location" {
  type    = list(string)
  default = ["ru-central1-a", "ru-central1-b"]
}
#___________________________________________________