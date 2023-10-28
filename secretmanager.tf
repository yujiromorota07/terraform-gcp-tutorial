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

data "google_secret_manager_secret_version" "db-host" {
  secret = google_secret_manager_secret.db-host.id
  version = "latest"
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

data "google_secret_manager_secret_version" "db-name" {
  secret = google_secret_manager_secret.db-name.id
  version = "latest"
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

data "google_secret_manager_secret_version" "db-user" {
  secret = google_secret_manager_secret.db-user.id
  version = "latest"
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

data "google_secret_manager_secret_version" "db-password" {
  secret = google_secret_manager_secret.db-password.id
  version = "latest"
}


resource "google_secret_manager_secret" "sample" {
  secret_id = "SAMPLE"
  replication {
    user_managed {
      replicas {
        location = var.default_region
      }
    }
  }
}

data "google_secret_manager_secret_version" "sample" {
  secret = google_secret_manager_secret.sample.id
  version = "latest"
}

