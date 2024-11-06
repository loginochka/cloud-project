resource "yandex_alb_http_router" "web-router" {
  name = var.alb-web-route-name[0]
}
resource "yandex_alb_virtual_host" "vh-for-web" {
  name           = var.alb-virtual-host-name[0]
  http_router_id = yandex_alb_http_router.web-router.id
  route {
    name = var.alb-virtual-host-route-name[0]
    http_route {
      http_route_action {
        backend_group_id = yandex_alb_backend_group.web-backend-group.id
        timeout          = var.alb-http-route-timeout[0]
      }
    }
  }
}
resource "yandex_alb_backend_group" "web-backend-group" {
  name = var.alb-backend-name[0]
  http_backend {
    name             = var.alb-http-backend-name[0]
    weight           = "1"
    port             = var.alb-http-backend-port[0]
    target_group_ids = ["${yandex_compute_instance_group.lamp-inst-group["main"].application_load_balancer.0.target_group_id}"]
    load_balancing_config {
      panic_threshold = 50
      mode            = "ROUND_ROBIN"
    }
    healthcheck {
      timeout  = var.alb-healthcheck-time[0]
      interval = var.alb-healthcheck-time[1]
      http_healthcheck {
        path = var.nlb-healthcheck-path[0]
      }
    }
  }
}
resource "yandex_alb_load_balancer" "alb-balancer" {
  name               = var.nlb-name[0]
  network_id         = yandex_vpc_network.vcod.id
  security_group_ids = ["${yandex_vpc_security_group.alb.id}"]
  allocation_policy {
    location {
      zone_id   = var.nlb-zone-name[0]
      subnet_id = yandex_vpc_subnet.public.id
    }
  }

  listener {
    name = var.nlb-listener-name[0]
    endpoint {
      address {
        external_ipv4_address {
        }
      }
      ports = [var.nlb-listener-port[0]]
    }
    http {
      handler {
        http_router_id = yandex_alb_http_router.web-router.id
      }
    }
  }
  log_options {
    discard_rule {
      http_code_intervals = ["HTTP_2XX"]
      discard_percent     = 75
    }
  }
}