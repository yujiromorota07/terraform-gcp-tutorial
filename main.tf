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

  deletion_protection  = "true"
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
  password = ""
}

resource "google_cloud_run_service" "gcp-tutorial-server" {
  name     = var.project_id
  location = var.default_region

  template {
    spec {
      containers {
        image = "asia.gcr.io/${var.project_id}/gcp-tutorial-server"
      }
    }
  }

  metadata {
      annotations = {
        "autoscaling.knative.dev/maxScale"      = "1000"
        "run.googleapis.com/cloudsql-instances" = google_sql_database_instance.gcp-tutorial-mysql-instance.connection_name
        "run.googleapis.com/client-name"        = "terraform"
      }
    }

  traffic {
    percent         = 100
    latest_revision = true
  }
}