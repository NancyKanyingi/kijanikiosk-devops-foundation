#!/bin/bash
set -e

echo "Initializing Terraform..."
terraform init

echo "Planning infrastructure..."
terraform plan

echo "Applying infrastructure..."
terraform apply -auto-approve

echo "Running Ansible..."
cd ansible
ansible-playbook site.yml

echo "Pipeline completed successfully."