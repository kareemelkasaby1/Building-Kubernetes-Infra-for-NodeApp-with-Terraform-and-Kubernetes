resource "kubernetes_persistent_volume_claim" "pvc-nexus" {
  metadata {
    name = "pvc-nexus"
    namespace = kubernetes_namespace.build.metadata[0].name
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    storage_class_name = "standard"
    resources {
      requests = {
        storage = "1.5Gi"
      }
    }
  }
}