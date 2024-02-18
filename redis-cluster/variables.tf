# providers.tf
variable "g_project" {
  type        = string
  description = "GCP project"
}
variable "g_region" { 
  type        = string
  description = "GCP region"
}
variable "g_credentials" {
  type        = string
  default     = null
  description = "GCP credentials path"
}

# main.tf
variable "name" {
  type        = string
  default     = "memstore-demo"
  description = "Name to be used as part of created resources' names"
}

# network
variable "network_tier" {
  type = string
  default = "STANDARD"
  description = "Default network pricing tier (STANDARD | PREMIUM)"
}

variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
  description = "IP Range for entire network"  
}

variable "subnet_cidr_offset" {
  type = number
  default = 8
  description = "Offset to determine CIDR mask for created subnets, determined from 'network_cidr_block' variable"
}

variable "public_subnet_count" {
  type = number
  default = 1
  description = "Number of public subnets"
}

variable "private_subnet_count" {
  type = number
  default = 1
  description = "Number of private subnets"
}

# redis
variable "shard_count" {
  type = number
  default = 3
  description = "Number of 13 GB shards in your instance"
}
variable "replica_count" {
  type = number
  default = 0
  description = "Number of read replicas (per shard)"
}