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

#variable "vpc-name" {
#  description = "name of the vpc the cluster will run"
#}

#variable "subnet_name" {
#  description = "name of the subnet the cluster will run"
#}