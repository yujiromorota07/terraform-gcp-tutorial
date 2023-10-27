resource "google_cloud_run_v2_service" "gcp-tutorial-server" {
  name     = var.project_id
  location = var.default_region

  template {
      containers {
        image = "asia.gcr.io/${var.project_id}/gcp-tutorial-server"

        env {
          name = "DB_HOST"
          value_source {
            secret_key_ref {
              secret = google_secret_manager_secret.db-host.secret_id
              version  = "latest"
            }
          }
        }

        env {
          name  = "DB_DATABASE"
          value_source {
            secret_key_ref {
              secret = google_secret_manager_secret.db-name.secret_id
              version  = "latest"
            }
          }
        }

        env {
          name  = "DB_USER"
          value_source {
            secret_key_ref {
              secret = google_secret_manager_secret.db-user.secret_id
              version  = "latest"
            }
          }
        }

        env {
          name  = "DB_PASSWORD"
          value_source {
            secret_key_ref {
              secret = google_secret_manager_secret.db-password.secret_id
              version  = "latest"
            }
          }
        }

        volume_mounts {
        name       = "cloudsql"
        mount_path = "/cloudsql"
        }
      }

      vpc_access{
      connector = google_vpc_access_connector.connector.id
      egress = "ALL_TRAFFIC"
    }

      volumes {
      name = "cloudsql"
      cloud_sql_instance {
        instances = [google_sql_database_instance.gcp-tutorial-mysql-instance.connection_name]
      }
    }
  }
    
  client     = "terraform"
  # depends_on = [google_project_service.secretmanager_api, google_project_service.cloudrun_api, google_project_service.sqladmin_api]
}