variable "project_id" {
  description = "project id"
}

variable "region" {
  description = "compute region"
}

variable "zone" {
  description = "compute zone"
}

variable "gke_num_nodes" {
  default     = 5
  description = "number of gke nodes"
}

variable "cluster_name" {
  description = "name of the application"
}

#variable "vpc_name" {
#  description = "name of the vpc the cluster will run"
#}

#variable "subnet_name" {
#  description = "name of the subnet the cluster will run"
#}