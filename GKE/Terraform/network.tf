# Tokenmetrics Trading Bot GKE Network
resource "google_compute_subnetwork" "subnet" {
  name          = lower("SUBNET-${local.resource_name_suffix}")
  ip_cidr_range = var.ip_cidr_range
  region        = var.region
  network       = google_compute_network.network.id

  secondary_ip_range {
    range_name    = "services-range"
    ip_cidr_range = var.pod_cidr_range
  }

  secondary_ip_range {
    range_name    = "pod-ranges"
    ip_cidr_range = var.service_cidr_range
  }

  log_config {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_network" "network" {
  name                    = "network-${local.resource_name_suffix}"
  auto_create_subnetworks = false
}

resource "google_compute_firewall" "allow_http_traffic" {
  name    = "allow-db-traffic"
  network = google_compute_network.network.name

  allow {
    protocol = "tcp"
    ports    = ["80", "443", "8080", "5432"]
  }
  target_tags   = ["my-node-1", "my-node-2"]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_global_address" "private_ip_address" {
  name          = "private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.network.id
}

resource "google_compute_address" "static_ip_address" {
  name         = "static-ip-address"
  address_type = "EXTERNAL"
}

resource "google_service_networking_connection" "node_private_vpc_connection" {
  network                 = google_compute_network.network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

