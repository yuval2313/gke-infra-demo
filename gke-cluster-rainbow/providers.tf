terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.38.0"
    }
  }
}

provider "google" {
  project     = var.g_project
  region      = var.g_region
  credentials = var.g_credentials
}
