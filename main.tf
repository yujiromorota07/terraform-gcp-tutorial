provider "google" {
  credentials = file("morota-gcp-tutorial-02e1f5c64fec.json") 
  project     = var.project_id 
  region      = var.default_region
}

resource "google_sql_database_instance" "gcp-tutorial-mysql-instance" {
  name             = "mysql-instance"
  database_version = "MYSQL_5_7"
  settings {
    tier = "db-f1-micro"
  }

  deletion_protection  = "false"
}

resource "google_sql_database" "gcp-tutorial-mysql-server" {
  name      = "mysql-server"
  instance  = google_sql_database_instance.gcp-tutorial-mysql-instance.name
  charset   = "utf8mb4"
  collation = "utf8mb4_bin"
}

resource "google_sql_user" "gcp-tutorial-db-user" {
  name     = "tutorial"
  instance = google_sql_database_instance.gcp-tutorial-mysql-instance.name
  host     = "%"
  //自身で設定
  password = "tutorial"
}

resource "google_cloud_run_v2_service" "gcp-tutorial-server" {
  name     = var.project_id
  location = var.default_region

  template {
      containers {
        image = "asia.gcr.io/${var.project_id}/gcp-tutorial-server"
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