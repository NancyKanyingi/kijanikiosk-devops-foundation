# KijaniKiosk API Server - Desired State Specification

## Identity
- Name: kijanikiosk-api
- Environment tag: staging
- Owner tag: amina

## Compute
- Provider: Multipass (local virtualization)
- Region: Local host
- Instance type: 1 vCPU, 1 GB RAM, 5 GB disk
- Operating system: Ubuntu 22.04.5 LTS (Jammy)
- Exact image ID: Ubuntu 22.04 image used by Multipass (to be looked up dynamically in Terraform)

## Networking
- VPC: Default Multipass virtual network
- Subnet: Default Multipass subnet
- Assign public IP: No (private IP only)
- Private IP address: 10.196.99.177

## Access Control
- SSH access: Port 22 (via Multipass)
- HTTP access: Port 80 (to be enabled when the application is deployed)
- All other inbound: Deny
- All outbound: Allow

## Storage
- Root volume: 5 GB

## Authentication
-SSH key pair name: kijanikiosk-key

## What must NOT exist on this server after provisioning
- No default password authentication
- No services listening other than sshd
- No world-writable directories outside /tmp

## Open questions
- Which Ubuntu image ID should Terraform use when provisioning on a cloud provider?
- Should Terraform generate a new SSH key pair or use an existing one?
- What cloud networking resources (VPC, subnet, firewall) will replace the Multipass virtual network?

## Hardest Decision and Why

The hardest decision was understanding the networking configuration. Multipass automatically creates and manages the virtual network and assigns a private IP address, whereas cloud providers require explicit choices for VPCs, subnets, routing, and firewall rules. It took some investigation to understand how the local networking provided by Multipass maps to cloud networking resources that Terraform will need to create explicitly.
