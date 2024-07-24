g_project = "rainbow-1141"
g_region = "us-east1"
g_credentials = null # Use 'gcloud auth application-default login' to get credentials
name_prefix = "rainbow-demo"

vpc_network_name = "rainbow-vpc"
vpc_subnet_name = "rainbow-vpc"
vpc_subnet_pod_range_name = "pod-ipv4-range-demo"
vpc_subnet_svc_range_name = "service-ipv4-range-demo"

gke_is_regional_cluster = false
gke_cluster_zones = ["us-east1-b"]
gke_cluster_master_cidr = "176.16.0.0/28"

gke_enable_logging_service = false
gke_enable_monitoring_service = false
gke_enable_managed_prometheus = false

gke_node_count = 5
gke_node_group_machine_type = "e2-medium"
gke_node_group_disk_type = "pd-ssd"
gke_node_group_disk_size = 30