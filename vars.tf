variable "project_id" {
  description = "project id"
}

variable "region" {
  description = "region"
}

variable "gke_num_nodes" {
  default     = 5
  description = "number of gke nodes"
}

variable "app_name" {
  description = "name of the app"
}