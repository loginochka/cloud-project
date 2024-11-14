resource "yandex_mdb_mysql_cluster" "mysql-cluster" {
  name                      = var.mysql-cluster-name
  network_id                = yandex_vpc_network.vcod.id
  environment               = "PRESTABLE"
  version                   = "8.0"
  backup_retain_period_days = 7
  security_group_ids        = [yandex_vpc_security_group.MySQL.id]
  deletion_protection       = "false"
  timeouts {
    create = "30m"
    delete = "30m"
    update = "30m"
  }
  backup_window_start {
    hours   = 23
    minutes = 59
  }
  maintenance_window {
    type = "ANYTIME"
  }
  resources {
    resource_preset_id = "b1.medium"
    disk_type_id       = "network-hdd"
    disk_size          = "20"
  }
  host {
    zone             = var.mysql-zone-location[0]
    subnet_id        = yandex_vpc_subnet.private-a.id
    assign_public_ip = "false"
    name             = "central1-a-node"
  }
  host {
    zone             = var.mysql-zone-location[1]
    subnet_id        = yandex_vpc_subnet.private-b.id
    assign_public_ip = "false"
    name             = "central1-b-node"
  }
  host {
    zone             = var.mysql-zone-location[1]
    subnet_id        = yandex_vpc_subnet.private-b.id
    assign_public_ip = "false"
    name             = "central1-b-node-2"
  }

}
resource "yandex_mdb_mysql_user" "mysql-user" {
  cluster_id            = yandex_mdb_mysql_cluster.mysql-cluster.id
  name                  = var.mysql-user-name[0]
  password              = var.mysql-user-password
  global_permissions    = ["REPLICATION_CLIENT", "REPLICATION_SLAVE", "PROCESS", "FLUSH_OPTIMIZER_COSTS", "SHOW_ROUTINE"]
  permission {
    database_name = yandex_mdb_mysql_database.mysql-db.name
    roles         = ["ALL"]
  }
}
resource "yandex_mdb_mysql_database" "mysql-db" {
  name       = var.mysql-db-name[0]
  cluster_id = yandex_mdb_mysql_cluster.mysql-cluster.id
}
