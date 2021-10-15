# Using a single workspace:
terraform {
  backend "gcs" {
    bucket  = "panwlabs-pc-tfstate"
    prefix  = "terraform/state"
  }
}