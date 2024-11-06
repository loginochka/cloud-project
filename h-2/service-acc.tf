resource "yandex_iam_service_account" "svc-lamp" {
  name = var.svc-name[0]
}

resource "yandex_resourcemanager_folder_iam_member" "editor" {
  folder_id = var.folder
  role      = var.svc-access[0]
  member    = "serviceAccount:${yandex_iam_service_account.svc-lamp.id}"
  depends_on = [
    yandex_iam_service_account.svc-lamp,
  ]
}