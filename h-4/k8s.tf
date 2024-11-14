resource "yandex_kubernetes_cluster" "regional-k8s-cluster" {
  name = "regional-k8s-cluster"
  timeouts {
    create = "30m"
    delete = "30m"
    read   = "30m"
    update = "30m"
  }
  network_id              = yandex_vpc_network.vcod.id
  service_account_id      = yandex_iam_service_account.svc-k8s.id
  node_service_account_id = yandex_iam_service_account.svc-k8s.id
  depends_on = [
    yandex_resourcemanager_folder_iam_member.editor
  ]
  node_ipv4_cidr_mask_size = 24
  cluster_ipv4_range       = var.k8s-cluster-ip-range[0]
  service_ipv4_range       = var.k8s-service-ip-range[0]
  release_channel          = "REGULAR"
  kms_provider {
    key_id = yandex_kms_symmetric_key.key-k8s.id
  }
  master {
    version            = var.k8s-version
    public_ip          = "true"
    security_group_ids = [
      yandex_vpc_security_group.k8s-main-sg.id,
      yandex_vpc_security_group.k8s-master-whitelist.id
    ]
    regional {
      region = "ru-central1"
      location {
        zone      = yandex_vpc_subnet.public-a.zone
        subnet_id = yandex_vpc_subnet.public-a.id
      }
      location {
        zone      = yandex_vpc_subnet.public-b.zone
        subnet_id = yandex_vpc_subnet.public-b.id
      }
      location {
        zone      = yandex_vpc_subnet.public-d.zone
        subnet_id = yandex_vpc_subnet.public-d.id
      }
    }
  }
}
resource "yandex_kubernetes_node_group" "k8s-node-group" {
  cluster_id = yandex_kubernetes_cluster.regional-k8s-cluster.id
  name       = "k8s-node-group"
  instance_template {
    platform_id = "standard-v2"
    metadata = {
      ssh-keys = "dadmin:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHg7C9mHbY/42x7ayDxRhG6xrP0WCQkkKBQvZV8ZwcrX"
    }
    resources {
      core_fraction = 5
      cores         = 4
      memory        = 4
    }
    boot_disk {
      size = var.k8s-node-gr-disk-size[0]
      type = var.k8s-node-gr-disk[0]
    }
    scheduling_policy {
      preemptible = "true"
    }
    network_interface {
      subnet_ids         = [yandex_vpc_subnet.public-a.id]
      nat                = "true"
      security_group_ids = [
        yandex_vpc_security_group.k8s-main-sg.id,
        yandex_vpc_security_group.k8s-nodes-ssh-access.id,
        yandex_vpc_security_group.k8s-public-services.id
      ]
    }
    container_runtime {
      type = "containerd"
    }
  }
  scale_policy {
    auto_scale {
      min = 3
      max = 6
      initial = 3
    }
  }
  allocation_policy {
    location {
      zone = yandex_vpc_subnet.public-a.zone
    }
  }
  deploy_policy {
    max_expansion   = 6
    max_unavailable = 3
  }

}