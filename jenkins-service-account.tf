resource "kubernetes_service_account" "jenkins-service-account" {
  metadata {
    name = "jenkins-service-account"
    namespace = "${kubernetes_namespace.build.metadata[0].name}"
  }
}