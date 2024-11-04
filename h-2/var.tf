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
variable "svc-name" {
  type                = list(string)
  default             = ["lamp-scale"]
}
variable "svc-access" {
  type                = list(string)
  default             = ["editor"]
}

#___________________________________________________
variable "vm-nat-inst-image-id" {
  type 		            = string
  default 	          = "fd8idcndp9uuidms4500"
  description          = "ubuntu-2204-nat"
}
variable "vm-nat-ipv4" {
  type 		            = string
  default 	          = "192.168.10.254"
}
variable "vm-image-id" {
  type 		            = string
  default 	          = "fd8p4jt9v2pfq4ol9jqh"
  description          = "ubuntu-2204"
}
variable "vm-lamp-image-id" {
  type 		            = string
  default 	          = "fd8b9oomokkmb8640iev"
  description          = "lamp"
}
variable "vm-disk-type" {
  type 		            = list(string)
  default 	          = ["network-hdd", "network-ssd", "network-ssd-nonreplicated", "network-ssd-io-m3"]
}
variable "vm-disk-size" {
  type                = list(string)
  default             = ["20"]
}
variable "vm-name" {
  type		            = list(string)
  default	            = ["vm-private", "vm-public", "lamp-inst-group"]
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
variable "vm-del-protect" {
  type		            = list(string)
  default	            = ["true", "false"] 
}
variable "vm-hcheck-int" {
  type		            = list(string)
  default	            = ["15"] 
}
variable "vm-hcheck-to" {
  type		            = list(string)
  default	            = ["5"] 
}
variable "vm-hcheck-threshold" {
  type		            = list(string)
  default	            = ["4", "2"] 
}
variable "vm-scale-unavailable" {
  type		            = list(string)
  default	            = ["2"] 
}
variable "vm-scale-expansion" {
  type		            = list(string)
  default	            = ["2"] 
}
variable "vm-scale-fixed" {
  type		            = list(string)
  default	            = ["3"] 
}
variable "vm-hcheck-port" {
  type		            = list(string)
  default	            = ["80", "443"] 
}
variable "vm-hcheck-path" {
  type		            = list(string)
  default	            = ["/"] 
}
variable "vm-preemptible" {
  type		            = list(string)
  default	            = ["true", "false"] 
}
variable "vm-nat-status" {
  type		            = list(string)
  default	            = ["true", "false"] 
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
variable "vm-lamp-resource" {
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
variable "target-group" {
  type                = list(string)
  default             = ["target-group-instance-vm"]
}
variable "nlb-name" {
  type                = list(string)
  default             = ["nlb-for-lamp"]
}
variable "nlb-zone-name" {
  type		            = list(string)
  default	            = ["ru-central1-a", "ru-central1-b", "ru-central1-d"] 
}
variable "nlb-listener-name" {
  type                = list(string)
  default             = ["nlb-web-listener"]
}
variable "nlb-listener-port" {
  type                = list(string)
  default             = ["80"]
}
variable "nlb-healthcheck-name" {
  type                = list(string)
  default             = ["nlb-http-health"]
}
variable "nlb-healthcheck-port" {
  type                = list(string)
  default             = ["80"]
}
variable "nlb-healthcheck-path" {
  type                = list(string)
  default             = ["/"]
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
  type		            = string
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
  default	            = ["22", "ANY", "TCP", "80"]
}
variable "vpc-sec-gr-name" {
  type		            = list(string)
  default	            = ["nat-instance-security-group", "lamp-security-group"]
}
#___________________________________________________
#___________S3______________________________________
variable "s3-name" {
  type                = string
  default             = "random-picture-from-web"
}
variable "s3-key" {
  type                = string
  default             = "city.jpg"
}
variable "s3-pic-path" {
  type                = string
  default             = "/home/danil/cloud-project/media/random-pic.jpg"
}
variable "s3-max-size" {
  type                = string
  default             = "1073741824"
}
variable "s3-class" {
  type                = list(string)
  default             = ["STANDARD", "COLD", "ICE"]
}
variable "s3-access-flag" {
  type                = list(string)
  default             = ["true", "false"]
}
variable "s3-acl" {
  type                = list(string)
  default             = ["private", "public-read", "public-read-write", "authenticated-read"]
}
variable "s3-content-type" {
  type                = string
  default             = "image/jpg"
}

#___________________________________________________

