| Control                          | What it does                                                           | Risk mitigated                                                 |
| -------------------------------- | ---------------------------------------------------------------------- | -------------------------------------------------------------- |
| Security Groups                  | Restricts network access to approved ports and sources.                | Reduces unauthorized network access.                           |
| SSH Key Pair                     | Uses key-based authentication instead of passwords.                    | Reduces the risk of password guessing attacks.                 |
| Remote Terraform State           | Stores infrastructure state in a centralized backend.                  | Reduces state loss and conflicting infrastructure changes.     |
| Least Privilege Service Accounts | Runs each service with its own identity.                               | Limits the impact if one service is compromised.               |
| `ProtectSystem`                  | Prevents services from modifying protected system resources.           | Reduces unauthorized system changes.                           |
| `ProtectHome`                    | Restricts service access to user home data.                            | Protects user information from accidental or malicious access. |
| `PrivateTmp`                     | Gives the service an isolated temporary workspace.                     | Prevents interference through shared temporary files.          |
| `NoNewPrivileges`                | Prevents the service from gaining additional privileges after startup. | Reduces the risk of privilege escalation.                      |


# Hardening Decisions for Nia

## Introduction

This document explains the security decisions made during the KijaniKiosk infrastructure automation project. The objective was not only to provision cloud infrastructure but also to ensure that every deployment follows consistent security practices. Rather than relying on manual configuration, the project encodes security decisions into infrastructure and configuration automation so that every deployment is repeatable, predictable, and easier to audit.

The infrastructure provisions three application servers using reusable infrastructure modules. Configuration management is then applied automatically to each server, ensuring that identical security controls are enforced across the environment. This approach reduces configuration drift, improves operational consistency, and minimizes the possibility of human error during deployment.

The following table summarizes the primary security controls implemented throughout the project.

| Control                     | What it does                                                                     | Risk mitigated                                                         |
| --------------------------- | -------------------------------------------------------------------------------- | ---------------------------------------------------------------------- |
| Security Groups             | Restricts network access to only approved services and ports.                    | Reduces unauthorized network access.                                   |
| SSH Key Pair Authentication | Uses cryptographic keys instead of passwords for administration.                 | Protects against password guessing and brute-force attacks.            |
| Remote Terraform State      | Stores infrastructure state in a centralized backend for consistent deployments. | Prevents conflicting infrastructure changes and accidental state loss. |
| Service Accounts            | Runs each application under a dedicated identity with limited permissions.       | Limits the impact of a compromised service.                            |
| ProtectSystem               | Prevents services from modifying protected operating system resources.           | Reduces the risk of unauthorized system modification.                  |
| ProtectHome                 | Restricts service access to user data.                                           | Protects user information from unintended access.                      |
| PrivateTmp                  | Gives each service its own isolated temporary workspace.                         | Prevents interference through shared temporary resources.              |
| NoNewPrivileges             | Prevents running services from gaining additional privileges after startup.      | Reduces opportunities for privilege escalation.                        |

The infrastructure follows the principle of least privilege throughout the deployment. Each application component operates independently using its own service identity instead of sharing a common privileged account. This separation limits the amount of damage that could occur if one component becomes compromised because access is restricted to only the permissions required for normal operation.

Network security is also an important part of the overall design. Instead of exposing every service directly to the network, only the necessary communication paths are permitted. Administrative access is restricted while unnecessary external access is denied. This reduces the available attack surface and helps ensure that only approved traffic reaches the application environment.

Another important design decision is the use of reusable infrastructure modules. By defining infrastructure components once and reusing them for multiple servers, every instance receives the same security configuration. This eliminates inconsistencies that commonly occur when servers are configured manually and makes future maintenance significantly easier.

Infrastructure state is stored remotely rather than locally. A centralized state repository provides a single source of truth for the deployed environment and helps prevent conflicting updates when infrastructure changes are made. This also improves collaboration by ensuring that every deployment references the same infrastructure state.

Configuration management further strengthens security by automatically applying identical configuration to every server. Instead of relying on manual administration after deployment, security settings are consistently enforced whenever the automation is executed. This reduces configuration drift and ensures that newly provisioned systems receive the same security posture as existing ones.

The application services are protected using several operating system isolation features. Each service operates within a constrained execution environment that limits its ability to modify critical system resources or access sensitive user information. These controls help reduce the consequences of software defects or successful attacks against individual services.

The use of isolated temporary storage ensures that application components cannot interfere with one another through shared temporary resources. Similarly, preventing services from acquiring additional privileges after startup reduces the likelihood that an attacker could expand access beyond the permissions originally assigned to the service.

Automation also improves operational security by making deployments repeatable. Every infrastructure deployment follows the same sequence of provisioning, configuration, and service deployment. This repeatability improves auditing because administrators can demonstrate that every server is built according to the same documented process instead of relying on undocumented manual changes.

Another benefit of infrastructure automation is easier recovery from failures. If a server must be replaced, the same automation can recreate the infrastructure and configuration with minimal manual intervention. This supports business continuity while maintaining consistent security controls across replacement systems.

The project also incorporates service management automation so that application services are deployed consistently and restarted whenever configuration changes occur. This ensures that configuration updates are applied correctly while reducing the possibility of operational mistakes during maintenance.

During testing, the deployment successfully provisioned the infrastructure, configured all application servers, and deployed the required services automatically. The automation demonstrated that the same security configuration could be reproduced consistently across multiple servers without requiring manual intervention.

The **kk-payments** service template reproduces the hardened configuration developed previously. The completed configuration is intended to achieve a **systemd security score below 2.5**, demonstrating a substantially reduced attack surface through layered operating system protections. The measured score should be recorded alongside the deployment evidence once verified using the appropriate security analysis tool.

Although these controls significantly improve the security posture of the deployment, they do not eliminate every possible risk. The current design cannot prevent vulnerabilities within the application itself, compromise resulting from stolen administrator credentials, insider threats, zero-day software vulnerabilities, or attacks introduced through trusted software dependencies. Additional monitoring, vulnerability management, security updates, credential protection, logging, and incident response processes remain essential to maintaining a secure production environment. Security should therefore be viewed as a continuous process rather than a one-time deployment activity.
