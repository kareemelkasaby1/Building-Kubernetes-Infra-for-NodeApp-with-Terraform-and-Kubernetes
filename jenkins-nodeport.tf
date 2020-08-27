resource "kubernetes_service" "jenkins-nodeport" {
  metadata {
    name = "jenkins-nodeport"
    namespace = "build"
  }
  spec {
    selector = {
      component = "${kubernetes_deployment.jenkins.metadata.0.labels.component}"
    }
    # session_affinity = "ClientIP"
    port {
      port        = 8080
      target_port = 8080
      node_port = 31515
    }

    type = "NodePort"
  }
}