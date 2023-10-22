
resource "google_cloud_run_v2_service" "gcp-tutorial-server" {
  name     = var.project_id
  location = var.default_region

  template {
      containers {
        image = "asia.gcr.io/${var.project_id}/gcp-tutorial-server"

        env {
          name = "DB_HOST"
          value = google_sql_database_instance.gcp-tutorial-mysql-instance.private_ip_address
        }

        env {
          name  = "DB_DATABASE"
          value = google_sql_database.gcp-tutorial-db.name
        }

        env {
          name  = "DB_USER"
          value = google_sql_user.gcp-tutorial-db-user.name
        }

        env {
          name  = "DB_PASSWORD"
          value = google_sql_user.gcp-tutorial-db-user.password 
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