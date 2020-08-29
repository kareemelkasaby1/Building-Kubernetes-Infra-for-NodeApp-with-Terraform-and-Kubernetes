resource "kubernetes_role_binding" "jenkins-role-binding-dev" {
  metadata {
    name      = "jenkins-role-binding-dev"
    namespace = "${kubernetes_namespace.dev.metadata[0].name}"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "${kubernetes_role.jenkins-role-dev.metadata.0.name}"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "${kubernetes_service_account.jenkins-service-account.metadata.0.name}"
    namespace = "${kubernetes_namespace.build.metadata[0].name}"
  }
}