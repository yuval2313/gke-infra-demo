g_project = "lyuval-playground"
g_region = "europe-north1"
g_credentials = null
name_prefix = "argocd-demo"
vpc_network_tier = "STANDARD"
vpc_subnet_primary_range = "10.0.0.0/24"
vpc_subnet_pod_range = "10.48.0.0/14"
vpc_subnet_svc_range = "10.52.0.0/20"
gke_deletion_protection = false
gke_is_regional_cluster = false
gke_cluster_zones = ["europe-north1-a"]
gke_cluster_master_cidr = "176.16.0.0/28"
gke_enable_private_nodes = true
gke_enable_logging_service = false
gke_enable_monitoring_service = false
gke_enable_managed_prometheus = false
gke_node_count = 3
gke_node_group_machine_type = "e2-medium"
gke_node_group_disk_type = "pd-ssd"
gke_node_group_disk_size = 30