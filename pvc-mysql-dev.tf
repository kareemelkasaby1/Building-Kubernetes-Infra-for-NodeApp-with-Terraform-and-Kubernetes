resource "kubernetes_persistent_volume_claim" "pvc-mysql-dev" {
  metadata {
    name = "pvc-mysql-dev"
    namespace = kubernetes_namespace.dev.metadata[0].name
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    storage_class_name = "standard"
    resources {
      requests = {
        storage = "1Gi"
      }
    }
  }
}