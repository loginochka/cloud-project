resource "yandex_iam_service_account" "svc-k8s" {
  name = var.svc-name[1]
}

resource "yandex_resourcemanager_folder_iam_member" "editor" {
  folder_id = var.folder
  role      = var.svc-access[0]
  member    = "serviceAccount:${yandex_iam_service_account.svc-k8s.id}"
  depends_on = [
    yandex_iam_service_account.svc-k8s,
  ]
}