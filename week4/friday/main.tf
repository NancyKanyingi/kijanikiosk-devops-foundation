terraform {
  backend "s3" {
    bucket = "kijanikiosk-tfstate"
    key    = "week4/wednesday/terraform.tfstate"
    region = "us-east-1"

    endpoint                    = "http://localhost:9000"
    access_key                  = "minioadmin"
    secret_key                  = "minioadmin"

    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_requesting_account_id  = true
    force_path_style            = true
  }
}

provider "aws" {
  region = var.aws_region
}

data "aws_ami" "ubuntu_22_04" {
  most_recent = true
  owners      = ["099720109477"] # Canonical (Ubuntu)

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

locals {
  servers = {
    api = {
      instance_type = "t3.micro"
    }

    payments = {
      instance_type = "t3.micro"
    }

    logs = {
      instance_type = "t3.micro"
    }
  }
}

module "app_servers" {
  source   = "./modules/app_server"
  for_each = local.servers

  name          = each.key
  instance_type = each.value.instance_type

  environment = var.environment

  
  ami_id   = data.aws_ami.ubuntu_22_04.id
  key_name = var.ssh_key_name
  subnet_id = var.subnet_id
  vpc_id    = var.vpc_id

}

