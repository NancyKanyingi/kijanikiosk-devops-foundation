# Manual Provisioning Decisions - KijaniKiosk API Server

| Decision | Value I chose | Reason |
|-----------|---------------|--------|
| Cloud provider | Multipass (local VM) | Using local virtualization instead of a public cloud |
| Region | Local machine | VM runs on my computer, so no cloud region is required |
| Operating system | Ubuntu 22.04 LTS | Required by the lab |
| Instance type | 1 vCPU, 1 GB RAM, 5 GB disk | Matches the Multipass launch command |
| VPC | Default Multipass virtual network | Automatically created by Multipass |
| Subnet | Default Multipass subnet | Automatically assigned |
| Security group | None (Multipass uses local networking) | Local VM does not use cloud security groups |
| SSH key pair | Multipass-managed key | Automatically managed by Multipass |
| Root volume size | 5 GB | Specified when creating the VM |
| Public IP? | No | VM is reachable only through the local virtual network |
| Tags / labels | kijanikiosk-api | Used to identify the VM |
