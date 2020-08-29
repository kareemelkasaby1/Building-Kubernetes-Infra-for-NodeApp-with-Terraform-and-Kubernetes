resource "kubernetes_role" "jenkins-role-dev" {
  metadata {
    name = "jenkins-role-dev"
    namespace = "${kubernetes_namespace.dev.metadata[0].name}"
    labels = {
      component = "jenkins-role-dev"
    }
  }
  rule {
    api_groups = ["*"]
    resources  = ["*"]
    verbs      = ["*"]
  }
}