resource "google_gke_backup_backup_plan" "backup_plan" {
  name     = lower("CLUSTER-BACKUP-PLAN-${local.resource_name_suffix}")
  cluster  = google_container_cluster.gke_cluster.id
  location = var.region
  backup_config {
    include_volume_data = true
    include_secrets     = true
    all_namespaces      = true
  }
  retention_policy {
    backup_delete_lock_days = var.backup_lock_days
    backup_retain_days      = var.backup_retain_days
  }
  backup_schedule {
    cron_schedule = "0 3 * * *"
  }
  lifecycle {
    prevent_destroy = true
  }
}

resource "google_gke_backup_restore_plan" "restore_plan" {
  name        = lower("CLUSTER-RESTORE-PLAN-${local.resource_name_suffix}")
  location    = var.region
  backup_plan = google_gke_backup_backup_plan.backup_plan.id
  cluster     = google_container_cluster.gke_cluster.id

  restore_config {
    all_namespaces                   = true
    namespaced_resource_restore_mode = "FAIL_ON_CONFLICT"
    volume_data_restore_policy       = "RESTORE_VOLUME_DATA_FROM_BACKUP"

    cluster_resource_restore_scope {
      all_group_kinds = true
    }

    cluster_resource_conflict_policy = "USE_EXISTING_VERSION"
  }
  lifecycle {
    prevent_destroy = true
  }
}