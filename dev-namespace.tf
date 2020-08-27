resource "kubernetes_namespace" "dev" {
  metadata {
    name = "dev"
  }
}