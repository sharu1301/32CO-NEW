variable "region" {
  description = "AWS region"
  type    = string
  default = "us-east-1"
}

variable "cluster_name" {
  type    = string
  default = "nodejs-app-cluster"
}

variable "rds_password" {
  type      = string
  sensitive = true
}

