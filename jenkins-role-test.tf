resource "kubernetes_role" "jenkins-role-test" {
  metadata {
    name = "jenkins-role-test"
    namespace = "${kubernetes_namespace.test.metadata[0].name}"
    labels = {
      component = "jenkins-role-test"
    }
  }
  rule {
    api_groups = ["*"]
    resources  = ["*"]
    verbs      = ["*"]
  }
}