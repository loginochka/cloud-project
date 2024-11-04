resource "yandex_compute_instance_group" "lamp-inst-group" {
  for_each                      = var.vm-lamp-resource
  name                          = var.vm-name[2]
  folder_id                     = var.folder
  service_account_id            = yandex_iam_service_account.svc-lamp.id
  deletion_protection           = var.vm-del-protect[1]
  depends_on                    = [yandex_resourcemanager_folder_iam_member.editor]
  scale_policy {
    fixed_scale {
        size                    = var.vm-scale-fixed[0]
    }
  }
  deploy_policy {
    max_unavailable             = var.vm-scale-unavailable[0]
    max_expansion               = var.vm-scale-expansion[0]
  }
  instance_template {
    platform_id                 = var.vm-platform
    boot_disk {
      initialize_params {
        size                    = var.vm-disk-size[0]
        type                    = var.vm-disk-type[0]
        image_id                = var.vm-lamp-image-id
      }
    }
    resources {
      memory                    = each.value.memory
      cores                     = each.value.cores
      core_fraction             = each.value.core_fraction
    }
    network_interface {
      network_id                = yandex_vpc_network.vcod.id
      subnet_ids                = ["${yandex_vpc_subnet.public.id}"]
      nat                       = var.vm-nat-status[1]
      security_group_ids        = ["${yandex_vpc_security_group.security-group-lamp.id}"]
    }
    scheduling_policy {
      preemptible               = var.vm-preemptible[0]
    }
  metadata = {
    user-data = templatefile("metadata/public-meta.tpl", {
      bucket = yandex_storage_bucket.s3-bucket.bucket
      key    = yandex_storage_object.s3-pic.key
    })
  }
  }
  allocation_policy {
    zones                       = [var.vm-zone-name[0]]
  }
  load_balancer {
    target_group_name           = var.target-group[0]
  }
#   application_load_balancer {
#     target_group_name           = var.target-group[0]
#   }
  health_check {
    interval                    = var.vm-hcheck-int[0]
    timeout                     = var.vm-hcheck-to[0]
    unhealthy_threshold         = var.vm-hcheck-threshold[0]
    healthy_threshold           = var.vm-hcheck-threshold[1]
    http_options {
      port                      = var.vm-hcheck-port[0]
      path                      = var.vm-hcheck-path[0]
    }
  }
}