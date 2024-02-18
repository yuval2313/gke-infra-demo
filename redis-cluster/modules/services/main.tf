resource "google_project_service" "api_service" {
  count = length(var.api_services)
  disable_on_destroy = false
  service = var.api_services[count.index]
}