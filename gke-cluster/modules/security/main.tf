locals {
    roles = [
        "roles/logging.logWriter",
        "roles/monitoring.metricWriter",
        "roles/monitoring.viewer",
        "roles/stackdriver.resourceMetadata.writer",
        "roles/autoscaling.metricsWriter",
        "roles/artifactregistry.reader"
    ]
}

resource "google_service_account" "gke_sa" {
  account_id   = "${var.name}-gke-sa"
  display_name = "GKE Service Account for ${var.name} terraform project"
}

resource "google_project_iam_binding" "role_bindings" {
  count = length(local.roles)
  project = var.g_project
  role    = local.roles[count.index]

  members = [
    "serviceAccount:${google_service_account.gke_sa.email}"
  ]
}