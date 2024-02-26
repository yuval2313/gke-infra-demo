variable name {
  type        = string
  description = "Name prefix for created resources"
}
variable description {
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
variable vpc_self_link {
  type        = string
  description = "URI of cluster VPC"
}
variable subnet_self_link {
  type        = string
  description = "URI of cluster subnet"
}
variable cluster_secondary_range_name {
  type = string
  description = "Name for k8s pod secondary ip range in subnet"
}  
variable services_secondary_range_name {
  type = string
  description = "Name for k8s service secondary ip range in subnet"
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

variable "service_account_email" {
  type        = string
  description = "Service account for node group"
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










