output k_config_cmd {
  value = "gcloud container clusters get-credentials ${module.gke.cluster_name} --region=${var.g_region}"
}