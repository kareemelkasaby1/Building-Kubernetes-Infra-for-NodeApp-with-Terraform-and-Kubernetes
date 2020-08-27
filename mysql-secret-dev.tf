resource "kubernetes_secret" "mysql-dev-secret" {
  metadata {
    name = "mysql-dev-secret"
    namespace = kubernetes_namespace.dev.metadata[0].name
  }

  data = {
    mysqlrootpassword = "123456"
    mysqluserpassword = "123456"
  }

  type = "kubernetes.io/generic"
}