output subnet {
  value = google_compute_subnetwork.subnet
}

output vpc {
  value = google_compute_network.vpc_network
}

output subnet_k8s_pod_range_name {
  value = local.subnet_k8s_pod_range_name
}

output subnet_k8s_svc_range_name {
  value = local.subnet_k8s_svc_range_name
}