resource "kubernetes_deployment" "mysql-dev" {
  metadata {
    name = "mysql-dev"
    labels = {
      component = "mysql-dev"
    }
    namespace = kubernetes_namespace.dev.metadata[0].name
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        component = "mysql-dev"
      }
    }

    template {
      metadata {
        labels = {
          component = "mysql-dev"
        }
      }
      spec {
        security_context {
          fs_group = "1000"
        }
        container {
          image = "mysql:8.0"
          name  = "mysql-dev"
          port {
            name = "http-port"
            container_port = 3306
          }
          volume_mount{
              name = "mysql-dev-storage"
              mount_path = "/var/lib/mysql"
          }
          env {
            name = "MYSQL_DATABASE"
            value = "task1database"
          }
          env {
            name = "MYSQL_USER"
            value = "kareem"
          }
          env {
            name = "MYSQL_ROOT_PASSWORD"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.mysql-dev-secret.metadata[0].name
                key = "mysqlrootpassword"
              }
            }
          }
          env {
            name = "MYSQL_PASSWORD"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.mysql-dev-secret.metadata[0].name
                key = "mysqluserpassword"
              }
            }
          }
          port {
            name = "mysql-port"
            container_port = 3306
          }
        }
        volume{
            name = "mysql-dev-storage"
            persistent_volume_claim{
                claim_name = "pvc-mysql-dev"
            }
        }
      }
    }
  }
}