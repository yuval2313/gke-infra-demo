# general

variable "g_project" {
  type        = string
  description = "GCP project."
}
variable "g_region" {
  type        = string
  description = "GCP region."
}
variable "g_credentials" {
  type        = string
  default     = null
  description = "GCP credentials path."
}

variable "name_prefix" {
  type        = string
  default     = "demo"
  description = "Name prefix to be used when creating resources."
}

# vpc

variable "vpc_network_name" {
  type        = string
  default     = "rainbow-vpc"
  description = "Name of the VPC in which cluster is hosted (defined outside of terraform)"
}
variable "vpc_subnet_name" {
  type        = string
  default     = "rainbow-vpc"
  description = "Name of the VPC subnet in which cluster is hosted (defined outside of terraform)"
}
variable "vpc_subnet_pod_range_name" {
  type        = string
  default     = "pod-ipv4-range-demo"
  description = "Name of the k8spod address range implemented as a secondary ip range within the vpc (defined outside of terraform)"
}
variable "vpc_subnet_svc_range_name" {
  type        = string
  default     = "service-ipv4-range-demo"
  description = "Name of the k8s service address range implemented as a secondary ip range within the vpc (defined outside of terraform)"
}

# variable vpc_subnet_pod_range {
#   type = string
#   default = "10.48.0.0/14"
#   description = "Secondary IP Range for cluster pods."  
# }

# variable vpc_subnet_svc_range {
#   type = string
#   default = "10.52.0.0/20"
#   description = "Secondary IP Range for cluster services."  
# }

# gke

variable "gke_is_regional_cluster" {
  type        = bool
  default     = false
  description = "Whether to create a regional cluster."
}
variable "gke_cluster_zones" {
  type        = list(string)
  default     = []
  description = "Zones for zonal cluster, ignored for regional clusters."
}
variable "gke_cluster_master_cidr" {
  type        = string
  default     = "176.16.0.0/28"
  description = "The IP range in CIDR notation to use for the hosted master network."
}

variable "gke_enable_logging_service" {
  type        = bool
  default     = false
  description = "Whether to enable managed logging service."
}
variable "gke_enable_monitoring_service" {
  type        = bool
  default     = false
  description = "Whether to enable managed monitoring service."
}
variable "gke_enable_managed_prometheus" {
  type        = bool
  default     = false
  description = "Whether to enable managed prometheus service."
}

variable "gke_node_count" {
  type        = number
  default     = 3
  description = "Number of nodes in cluster node group."
}
variable "gke_node_group_machine_type" {
  type        = string
  default     = "e2-small"
  description = "Machine type for node group."
}
variable "gke_node_group_disk_type" {
  type        = string
  default     = "pd-ssd"
  description = "Persistent disk type attached to each node in node group."
}
variable "gke_node_group_disk_size" {
  type        = number
  default     = 30
  description = "Persistent disk size attached to each node in node group."
}
