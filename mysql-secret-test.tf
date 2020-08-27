resource "kubernetes_secret" "mysql-test-secret" {
  metadata {
    name = "mysql-test-secret"
    namespace = kubernetes_namespace.test.metadata[0].name
  }

  data = {
    mysqlrootpassword = "123456"
    mysqluserpassword = "123456"
  }

  type = "kubernetes.io/generic"
}