resource "kubernetes_service" "mysql-test-nodeport" {
  metadata {
    name = "mysql-nodeport"
    namespace = "test"
  }
  spec {
    selector = {
      component = "${kubernetes_deployment.mysql-test.metadata.0.labels.component}"
    }
    # session_affinity = "ClientIP"
    port {
      port        = 3306
      target_port = 3306
      node_port = 31518
    }

    type = "NodePort"
  }
}