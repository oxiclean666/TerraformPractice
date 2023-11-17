variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "vpc" {
  type = string
  default = "Tims-VPC"
  description = "The name of the VPC that will hold the Kubernetes Cluster"
}

