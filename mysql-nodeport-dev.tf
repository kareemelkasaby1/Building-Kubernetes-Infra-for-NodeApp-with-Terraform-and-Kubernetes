resource "kubernetes_service" "mysql-dev-nodeport" {
  metadata {
    name = "mysql-nodeport"
    namespace = "dev"
  }
  spec {
    selector = {
      component = "${kubernetes_deployment.mysql-dev.metadata.0.labels.component}"
    }
    # session_affinity = "ClientIP"
    port {
      port        = 3306
      target_port = 3306
      node_port = 31519
    }

    type = "NodePort"
  }
}