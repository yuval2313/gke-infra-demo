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

# network module
variable network_tier {
  type        = string
  default     = "STANDARD"
  description = "GCP network service tier (PREMIUM | STANDARD)"
}
variable network_cidr_block {
  type = string
  default = "10.0.0.0/16"
  description = "IP Range for entire network"  
}
variable subnet_cidr_offset {
  type = number
  default = 8
  description = "Offset to determine CIDR mask for created subnets, determined from 'network_cidr_block' variable"
}

# gke module
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
variable preemptible_nodes {
  type        = bool
  default     = false
  description = "Whether nodes are preemptible nodes, set to true only for fault-tolerant workloads"
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

variable logging_service {
  type        = string
  default     = "none"
  description = "Managed logging service (logging.googleapis.com | logging.googleapis.com/kubernetes | none)"
}
variable monitoring_service {
  type        = string
  default     = "none"
  description = "Managed monitoring service (monitoring.googleapis.com | monitoring.googleapis.com/kubernetes | none)"
}
variable enable_managed_prometheus {
  type        = bool
  default     = false
  description = "Whether to enable managed prometheus service"
}