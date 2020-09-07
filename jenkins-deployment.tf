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
        volume {
          name = "docker"
          empty_dir {}
        }
        volume {
          name = "terraform"
          empty_dir {}
        }
        volume {
          name = "docker-socket"
          host_path {
            path = "/var/run/docker.sock"
            type = "File"
          }
        }
        init_container {
          name = "install-kubectl"
          image = "eslamkarim/jenkins-ansible-kubectl"
          volume_mount {
            name = "kubectl"
            mount_path = "/data"
          }
          command = ["cp", "/usr/local/bin/kubectl", "/data/kubectl"]
        }
        init_container {
          name = "install-docker"
          image = "docker:stable"
          volume_mount {
            name = "docker"
            mount_path = "/data"
          }
          command = ["cp", "/usr/local/bin/docker", "/data/docker"]
        }
        init_container {
          name = "install-terraform"
          image = "hashicorp/terraform:light"
          volume_mount {
            name = "terraform"
            mount_path = "/data"
          }
          command = ["cp", "/bin/terraform", "/data/terraform"]
        }
        service_account_name = "${kubernetes_service_account.jenkins-service-account.metadata.0.name}"
        automount_service_account_token = "true"
        container {
          image = "kareemelkasaby/jenkinsfordockerminikube:v1"
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
          volume_mount{
              name = "docker"
              sub_path = "docker"
              mount_path = "/usr/local/bin/docker"
          }
          volume_mount{
              name = "terraform"
              sub_path = "terraform"
              mount_path = "/usr/local/bin/terraform"
          }
          volume_mount {
            mount_path = "/var/run/docker.sock"
            name = "docker-socket"
          }
          #run the command of minikube docker-env and take the env names and values from it
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