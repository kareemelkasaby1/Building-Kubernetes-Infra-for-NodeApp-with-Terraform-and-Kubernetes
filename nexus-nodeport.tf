resource "kubernetes_service" "nexus-nodeport" {
  metadata {
    name = "nexus-nodeport"
    namespace = "build"
  }
  spec {
    selector = {
      component = "${kubernetes_deployment.nexus.metadata.0.labels.component}"
    }
    port {
      name = "http-port"
      port        = 8081
      target_port = 8081
      node_port = 31516
    }
    port {
      name = "https-port"
      port        = 8443
      target_port = 8443
    }
    type = "NodePort"
  }
}