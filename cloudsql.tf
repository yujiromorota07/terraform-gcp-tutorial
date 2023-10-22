
resource "google_sql_database_instance" "gcp-tutorial-mysql-instance" {
  name             = "mysql-instance"
  database_version = "MYSQL_5_7"
  settings {
    tier = "db-f1-micro"
     ip_configuration {
      private_network = google_compute_network.this.self_link
    }
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

resource "google_sql_database" "gcp-tutorial-db" {
  name       = "tutorial"
  instance   = google_sql_database_instance.gcp-tutorial-mysql-instance.name
  collation  = "utf8_general_ci"
}
