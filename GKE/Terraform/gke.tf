data "google_service_account" "myaccount" {
  account_id = var.service_account_name
}

resource "google_container_cluster" "gke_cluster" {
  name                     = lower("CLUSTER-${local.resource_name_suffix}")
  location                 = var.region
  remove_default_node_pool = true
  initial_node_count       = 1
  deletion_protection      = false
  network                  = google_compute_network.network.id
  subnetwork               = google_compute_subnetwork.subnet.id

  cluster_autoscaling {
    enabled = true
    resource_limits {
      resource_type = "cpu"
      minimum       = var.cpu_min_cores
      maximum       = var.cpu_max_cores
    }

    resource_limits {
      resource_type = "memory"
      maximum       = var.memory_max
      minimum       = var.memory_min

    }
    autoscaling_profile = "BALANCED"
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  addons_config {
    horizontal_pod_autoscaling {
      disabled = false
    }
    http_load_balancing {
      disabled = false
    }
    gke_backup_agent_config {
      enabled = true
    }
    gcs_fuse_csi_driver_config {
      enabled = true
    }
  }

  monitoring_config {
    managed_prometheus {
      enabled = true
    }
    enable_components = ["SYSTEM_COMPONENTS", "APISERVER", "SCHEDULER", "CONTROLLER_MANAGER", "POD", "DEPLOYMENT", "HPA", "STORAGE", "STATEFULSET", "DAEMONSET"]
  }

  logging_config {
    enable_components = ["SYSTEM_COMPONENTS", "APISERVER", "SCHEDULER", "CONTROLLER_MANAGER", "WORKLOADS"]
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = "pod-ranges"
    services_secondary_range_name = google_compute_subnetwork.subnet.secondary_ip_range.0.range_name
  }

  vertical_pod_autoscaling {
    enabled = true
  }

  network_policy {
    enabled  = true
    provider = "CALICO"
  }

  timeouts {
    create = "30m"
    update = "30m"
    delete = "30m"
  }

  resource_labels = local.resource_labels
}

resource "google_container_node_pool" "gke_node_1" {
  name    = lower("MY-NODE-1-${local.resource_name_suffix}")
  cluster = google_container_cluster.tm_gke_cluster.id

  autoscaling {
    total_max_node_count = var.max_node_count
    total_min_node_count = var.min_node_count
    location_policy      = "BALANCED"
  }

  node_config {
    tags         = ["my-node-1"]
    preemptible  = var.preemptible
    machine_type = var.machine_type

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = data.google_service_account.myaccount.email
    oauth_scopes    = ["https://www.googleapis.com/auth/cloud-platform"]
  }
  management {
    auto_repair  = true
    auto_upgrade = true
  }
}

resource "google_container_node_pool" "gke_node_2" {
  name       = lower("MY-NODE-2-${local.resource_name_suffix}")
  cluster    = google_container_cluster.tm_gke_cluster.id
  location   = var.region
  node_count = var.min_node_count

  autoscaling {
    max_node_count  = var.max_node_count
    min_node_count  = var.min_node_count
    location_policy = "BALANCED"
  }

  node_config {
    preemptible  = var.preemptible
    machine_type = var.machine_type
    disk_size_gb = 10
    disk_type    = "pd-ssd"
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = data.google_service_account.myaccount.email
    oauth_scopes    = ["https://www.googleapis.com/auth/cloud-platform"]
    labels = {
      workload = "trading-bot-only"
    }
    local_ssd_count = 0
    tags            = ["my-node-2"]
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }
}
