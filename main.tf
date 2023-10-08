provider "google" {
  credentials = file("morota-gcp-tutorial-02e1f5c64fec.json") 
  project     = var.project_id 
  region      = var.default_region
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

  traffic {
    percent         = 100
    latest_revision = true
  }
}