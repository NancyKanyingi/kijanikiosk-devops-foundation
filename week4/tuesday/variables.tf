variable "aws_region" {
  description = "AWS region to deploy infrastructure into"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"

  validation {
    condition     = startswith(var.instance_type, "t")
    error_message = "Instance type must start with 't'."
  }
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "staging"

  validation {
    condition     = contains(["staging", "production"], var.environment)
    error_message = "Environment must be staging or production."
  }
}

variable "server_name" {
  description = "Name of the EC2 instance"
  type        = string
  default     = "kijanikiosk-api"
}

variable "ssh_key_name" {
  description = "Name of the EC2 SSH key pair"
  type        = string
}