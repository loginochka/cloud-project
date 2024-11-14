#___________Instance__________________________________
resource "yandex_compute_instance" "vm-public" {
  name        = var.vm-name[1]
  platform_id = var.vm-platform
  zone        = var.vm-zone-name[0]
  hostname    = var.vm-hostname[1]
  metadata = {
    user-data = file("metadata/public-meta.txt")
  }
  for_each = var.vm-nat-resource
  resources {
    cores         = each.value.cores
    memory        = each.value.memory
    core_fraction = each.value.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = var.vm-nat-inst-image-id
      type     = var.vm-disk-type[0]
    }
  }
  network_interface {
    subnet_id  = yandex_vpc_subnet.public-a.id
    nat        = true
    ip_address = var.vm-nat-ipv4
  }
}
#___________________________________________________