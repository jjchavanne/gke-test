# Using a single workspace:
terraform {
  backend "gcs" {
    bucket  = var.bucket
    prefix  = "terraform/state"
  }
}