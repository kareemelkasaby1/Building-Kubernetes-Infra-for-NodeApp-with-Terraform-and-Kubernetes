resource "kubernetes_role_binding" "jenkins-role-binding-test" {
  metadata {
    name      = "jenkins-role-binding-test"
    namespace = "${kubernetes_namespace.test.metadata[0].name}"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "${kubernetes_role.jenkins-role-test.metadata.0.name}"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "${kubernetes_service_account.jenkins-service-account.metadata.0.name}"
    namespace = "build"
  }
}