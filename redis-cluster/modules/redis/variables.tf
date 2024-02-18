variable "name" {
  type = string
}
variable "g_region" {
  type = string
}

variable "vpc_id" {
  type = string
}
variable "subnet_ids" {
  type = list
}

variable "shard_count" {
  type = number
}
variable "replica_count" {
  type = number
}

variable "authorization_mode" {
  type = string
  default = "AUTH_MODE_DISABLED"
}
variable "transit_encryption_mode" {
  type = string
  default = "TRANSIT_ENCRYPTION_MODE_DISABLED"
}