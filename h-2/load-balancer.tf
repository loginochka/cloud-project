resource "yandex_lb_network_load_balancer" "lamp-lb" {
  name                      = var.nlb-name[0]
  folder_id                 = var.folder
  listener {
    name                    = var.nlb-listener-name[0]
    port                    = var.nlb-listener-port[0]
  }
  attached_target_group {
    target_group_id         = yandex_compute_instance_group.lamp-inst-group["main"].load_balancer.0.target_group_id

    healthcheck {
      name                  = var.nlb-healthcheck-name[0]
      http_options {
        port                = var.nlb-healthcheck-port[0]
        path                = var.nlb-healthcheck-path[0]
      }
    }
  }
}
