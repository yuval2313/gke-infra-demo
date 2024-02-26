# providers.tf
variable g_project {
  type        = string
  description = "GCP project"
}
variable g_region { 
  type        = string
  description = "GCP region"
}
variable g_credentials {
  type        = string
  default     = null
  description = "GCP credentials path"
}

# main.tf
variable name {
  type        = string
  default     = "demo"
  description = "Name to be used as part of created resources' names"
}

# network
variable network_tier {
  type        = string
  default     = "STANDARD"
  description = "GCP network service tier (PREMIUM | STANDARD)"
}

variable subnet_primary_cidr {
  type = string
  default = "10.0.0.0/24"
  description = "Primary IP Range for cluster subnet"  
}
variable subnet_k8s_pod_cidr {
  type = string
  default = "10.48.0.0/14"
  description = "Secondary IP Range for cluster pods"  
}
variable subnet_k8s_svc_cidr {
  type = string
  default = "10.52.0.0/20"
  description = "Secondary IP Range for cluster services"  
}

# cluster
variable cluster_description {
  type        = string
  default     = ""
  description = "Cluster description"
}
variable is_private_cluster {
  type        = bool
  default     = true
  description = "Whether to deploy worker nodes without external IPs"
}

variable networking_mode {
  type        = string  
  default     = "VPC_NATIVE"
  description = "Networking mode (VPC_NATIVE | ROUTES)"
}

variable is_zonal_cluster {
  type        = bool
  default     = true
  description = "Whether to create a zonal cluster"
}
variable cluster_zone {
  type        = string
  description = "Zone for zonal cluster, ignored if 'is_zonal_cluster' variable is set to 'false'"
}
variable cluster_master_cidr {
  type        = string
  default     = "176.16.0.0/28"
  description = "The IP range in CIDR notation to use for the hosted master network"
}

variable enable_logging_service {
  type        = bool
  default     = false
  description = "Whether to enable managed logging service"
}
variable enable_monitoring_service {
  type        = bool
  default     = false
  description = "Whether to enable managed monitoring service"
}
# variable enable_managed_prometheus {
#   type        = bool
#   default     = false
#   description = "Whether to enable managed prometheus service"
# }
variable release_channel {
  type        = string
  default     = "REGULAR"
  description = "Release channel for control plane kubernetes version (UNSPECIFIED | RAPID | REGULAR | STABLE)"
}

variable node_count {
  type        = number
  default     = 1
  description = "Number of nodes in cluster node group"
}
variable node_group_machine_type {
  type        = string
  default     = "e2-small"
  description = "Machine type for node group"
}
variable node_group_auto_repair {
  type        = bool
  default     = true
  description = "Whether to auto repair nodes in the node group"
}
variable node_group_auto_upgrade {
  type        = bool
  default     = true
  description = "Whether to auto upgrade nodes in the node group"
}