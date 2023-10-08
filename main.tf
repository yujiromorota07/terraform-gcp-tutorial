provider "google" {
  credentials = file("morota-gcp-tutorial-02e1f5c64fec.json") 
  project     = var.project_id 
  region      = var.default_region
}