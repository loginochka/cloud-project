#___________________________________________________
variable "token" {
  sensitive   	      = true
}
variable "folder" {
  sensitive   	      = true
}
variable "cloud" {
  sensitive	          = true
}
#___________________________________________________
variable "vm-nat-inst-image-id" {
  type 		            = string
  default 	          = "fd8idcndp9uuidms4500"
}
variable "vm-nat-ipv4" {
  type 		            = string
  default 	          = "192.168.10.254"
}
variable "vm-image-id" {
  type 		            = string
  default 	          = "fd8p4jt9v2pfq4ol9jqh"
}
variable "vm-disk-type" {
  type 		            = list(string)
  default 	          = ["network-hdd"]
}
variable "vm-name" {
  type		            = list(string)
  default	            = ["vm-private", "vm-public"]
}
variable "vm-platform" {
  type 		            = string
  default	            = "standard-v1"
}
variable "vm-zone-name" {
  type		            = list(string)
  default	            = ["ru-central1-a", "ru-central1-b", "ru-central1-d"] 
}
variable "vm-hostname" {
  type		            = list(string)
  default	            = ["ubupriv", "ubupub"] 
}
variable "vm-resource" {
    type              = map(object({
    cores             = number
    memory            = number
    core_fraction     = number
  }))
  default             = {
    main              = {
      cores           = 4
      memory          = 4
      core_fraction   = 5
    }
  }
}
variable "vm-nat-resource" {
    type              = map(object({
    cores             = number
    memory            = number
    core_fraction     = number
  }))
  default             = {
    main              = {
      cores           = 4
      memory          = 4
      core_fraction   = 5
    }
  }
}
#___________________________________________________
variable "vpc-name" {
  type 		            = string
  default 	          = "vcod"
}
variable "vpc-sub-name" {
  type    	          = list(string)
  default 	          = ["public", "private"]
}
variable "vpc-sub-ip" {
  type 		            = list(string)
  default 	          = ["192.168.10.0/24", "192.168.20.0/24"]
}
variable "vpc-zone-name" {
  type 		            = list(string)
  default 	          = ["ru-central1-a"]
}
variable "vpc-rt-name" {
  type		                        = string
  default	            = "default-nat-rt"
}
variable "vpc-rt-prefix" {
  type		            = list(string)
  default	            = ["0.0.0.0/0"]
}
variable "vpc-sec-gr-ip" {
  type		            = list(string)
  default	            = ["0.0.0.0/0"]
}
variable "vpc-sec-gr-port-proto" {
  type		            = list(string)
  default	            = ["22", "ANY", "TCP"]
}
variable "vpc-sec-gr-name" {
  type		            = string
  default	            = "nat-instance-security-group"
}
#___________________________________________________
