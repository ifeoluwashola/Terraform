resource "google_sql_database_instance" "db_instance" {
  name             = "${random_id.db_name_suffix.hex}"
  region           = var.region
  database_version = "POSTGRES_15"
  deletion_protection = false
  depends_on = [google_service_networking_connection.node_private_vpc_connection]

  settings {
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled                                  = false
      private_network                               = google_compute_network.network.self_link
      enable_private_path_for_google_cloud_services = true
    }
  }
  root_password = var.root_password
  lifecycle {
    prevent_destroy = false
  }
}

resource "random_id" "db_name_suffix" {
  byte_length = 4
}

resource "google_sql_database" "name" {
  name = "airflow"
  instance = google_sql_database_instance.db_instance.name
  deletion_policy = "DELETE"
}