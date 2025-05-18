variable "cluster_name" {
  type = string
}

variable "eks_cluster_role_arn" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "node_role_arn" {
  type = string
}

variable "instance_types" {
  type = string
}