output private_subnets {
  value       = google_compute_subnetwork.private_subnets
  description = "List of private subnets created"
}
output public_subnets {
  value       = google_compute_subnetwork.public_subnets
  description = "List of public subnets created"
}

output vpc_self_link {
  value       = google_compute_network.vpc_network.self_link
  description = "The URI of the created VPC"
}
