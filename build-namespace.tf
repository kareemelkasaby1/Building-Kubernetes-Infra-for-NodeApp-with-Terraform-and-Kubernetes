resource "kubernetes_namespace" "build" {
  metadata {
    name = "build"
  }
}