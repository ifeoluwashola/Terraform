environment                 = "myenv"
region                      = "asia-east2"
project_name                = "my-project"
project_id                  = "my-project-id"
ip_cidr_range               = "10.0.0.0/16"
service_account_name        = "GKE-SERVICE-ACCOUNT"
cpu_max_cores               = 8
cpu_min_cores               = 1
memory_max                  = 64
memory_min                  = 1
preemptible                 = false
backup_lock_days            = 30
backup_retain_days          = 180
pod_cidr_range              = "192.168.1.0/24"
service_cidr_range          = "192.168.64.0/22"
min_node_count              = 0
max_node_count              = 4
machine_type                = "n1-standard-2"
platformversion             = "my-version"