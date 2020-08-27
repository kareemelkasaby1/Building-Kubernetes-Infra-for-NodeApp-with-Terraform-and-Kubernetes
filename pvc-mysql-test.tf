resource "kubernetes_persistent_volume_claim" "pvc-mysql-test" {
  metadata {
    name = "pvc-mysql-test"
    namespace = kubernetes_namespace.test.metadata[0].name
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