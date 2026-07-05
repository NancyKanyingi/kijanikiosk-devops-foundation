variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
  default     = "us-east-1"
}

variable "ssh_key_name" {
  description = "EC2 key pair name"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}

variable "subnet_id" {
  description = "Subnet ID where EC2 instances will be created"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID used by the security groups"
  type        = string
}