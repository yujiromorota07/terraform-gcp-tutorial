resource "google_secret_manager_secret" "db-host" {
  secret_id = "DB_HOST"
  replication {
    user_managed {
      replicas {
        location = var.default_region
      }
    }
  }
}

resource "google_secret_manager_secret_version" "db-host" {
  secret = google_secret_manager_secret.db-host.id
  secret_data = "10.20.0.11"
}

resource "google_secret_manager_secret" "db-name" {
  secret_id = "DB_NAME"
  replication {
    user_managed {
      replicas {
        location = var.default_region
      }
    }
  }
}

resource "google_secret_manager_secret_version" "db-name" {
  secret = google_secret_manager_secret.db-name.id
  secret_data = "tutorial"
}

resource "google_secret_manager_secret" "db-user" {
  secret_id = "DB_USER"
  replication {
    user_managed {
      replicas {
        location = var.default_region
      }
    }
  }
}

resource "google_secret_manager_secret_version" "db-user" {
  secret = google_secret_manager_secret.db-user.id
  secret_data = "tutorial"
}


resource "google_secret_manager_secret" "db-password" {
  secret_id = "DB_PASSWORD"
  replication {
    user_managed {
      replicas {
        location = var.default_region
      }
    }
  }
}

resource "google_secret_manager_secret_version" "db-password" {
  secret = google_secret_manager_secret.db-password.id
  secret_data = "tutorial"
}

