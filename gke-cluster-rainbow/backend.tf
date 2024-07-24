terraform {
  backend "gcs" {
    bucket = "cp-yuv-tf-backend"
    prefix = "terraform/gke-rainbow/state"
  }
}
