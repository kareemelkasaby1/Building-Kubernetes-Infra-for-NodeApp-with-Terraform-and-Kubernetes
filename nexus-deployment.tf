resource "kubernetes_deployment" "nexus" {
  metadata {
    name = "nexus"
    labels = {
      component = "nexus"
    }
    namespace = kubernetes_namespace.build.metadata[0].name
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        component = "nexus"
      }
    }

    template {
      metadata {
        labels = {
          component = "nexus"
        }
      }
      spec {
        security_context {
          fs_group = "200"
        }
        container {
          image = "sonatype/nexus3"
          name  = "nexus"
          port {
            name = "http-port"
            container_port = 8081
          }
          port {
            name = "private-port"
            container_port = 8443
          }
          volume_mount{
            name = "nexus-storage"
            mount_path = "/nexus-data"
          }
        }
        volume{
            name = "nexus-storage"
            persistent_volume_claim{
                claim_name = "pvc-nexus"
            }
        }
      }
    }
  }
}