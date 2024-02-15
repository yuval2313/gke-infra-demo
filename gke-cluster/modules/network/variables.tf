variable name {
  type        = string
  description = "Name prefix for created resources"
}
variable g_region {
  type        = string
  description = "GCP region"
}
variable network_tier {
  type        = string
  default     = "STANDARD"
  description = "GCP network service tier (PREMIUM | STANDARD)"
}
variable is_private_subnet {
  type        = bool
  default     = true
  description = "Whether to create a public or a private subnet with NAT"
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