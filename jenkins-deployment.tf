resource "kubernetes_deployment" "jenkins" {
  metadata {
    name = "jenkins"
    labels = {
      component = "jenkins"
    }
    namespace = kubernetes_namespace.build.metadata[0].name
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        component = "jenkins"
      }
    }

    template {
      metadata {
        labels = {
          component = "jenkins"
        }
      }
      spec {
        security_context {
          fs_group = "1000"
        }
        service_account_name = "${kubernetes_service_account.jenkins-service-account.metadata.0.name}"
        container {
          image = "kareemelkasaby/jenkins:v1"
          name  = "jenkins"
          port {
            name = "http-port"
            container_port = 8080
          }
          port {
            name = "jnlp-port"
            container_port = 50000
          }
          volume_mount{
              name = "jenkins-storage"
              mount_path = "/var/jenkins_home"
          }
        }
        volume{
            name = "jenkins-storage"
            persistent_volume_claim{
                claim_name = "pvc-jenkins"
            }
        }
      }
    }
  }
}