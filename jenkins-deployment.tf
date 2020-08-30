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
        volume {
          name = "kubectl"
          empty_dir {}
        }
        init_container {
          name = "install-kubectl"
          image = "allanlei/kubectl"
          volume_mount {
            name = "kubectl"
            mount_path = "/data"
          }
          command = ["cp", "/usr/local/bin/kubectl", "/data/kubectl"]
        }
        service_account_name = "${kubernetes_service_account.jenkins-service-account.metadata.0.name}"
        automount_service_account_token = "true"
        container {
          image = "jenkins/jenkins:lts"
          name  = "jenkins"
          port {
            name = "http-port"
            container_port = 8080
          }
          port {
            name = "jnlp-port"
            container_port = 50000
          }
          volume_mount {
              name = "jenkins-storage"
              mount_path = "/var/jenkins_home"
          }
          volume_mount{
              name = "kubectl"
              sub_path = "kubectl"
              mount_path = "/usr/local/bin/kubectl"
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