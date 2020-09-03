resource "kubernetes_deployment" "mysql-test" {
  metadata {
    name = "mysql-test"
    labels = {
      component = "mysql-test"
    }
    namespace = kubernetes_namespace.test.metadata[0].name
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        component = "mysql-test"
      }
    }

    template {
      metadata {
        labels = {
          component = "mysql-test"
        }
      }
      spec {
        security_context {
          fs_group = "1000"
        }
        container {
          image = "mysql:5.7"
          name  = "mysql-test"
          port {
            name = "http-port"
            container_port = 3306
          }
          volume_mount{
              name = "mysql-test-storage"
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
                name = kubernetes_secret.mysql-test-secret.metadata[0].name
                key = "mysqlrootpassword"
              }
            }
          }
          env {
            name = "MYSQL_PASSWORD"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.mysql-test-secret.metadata[0].name
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
            name = "mysql-test-storage"
            persistent_volume_claim{
                claim_name = "pvc-mysql-test"
            }
        }
      }
    }
  }
}