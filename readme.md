


# Azure Landing Zone

This project implements a secure and scalable Azure Landing Zone architecture following Microsoft's best practices for enterprise-grade cloud deployments.

## Overview

The goal of this project is to deploy a landing zone on Azure that meets the following requirements:
- **Project Isolation**: Complete separation between different projects using a hub-and-spoke model
- **Team Autonomy**: Self-service creation and management of Azure PaaS services by project teams
- **Microsoft Alignment**: Implementation follows Microsoft's recommended practices and Cloud Adoption Framework

## Architecture

### Hub-and-Spoke Model
- **Centralized Hub**: Contains shared services including DNS resolution, private DNS zones, and network connectivity
- **Isolated Spokes**: Each project gets its own virtual network for complete isolation
- **Network Peering**: Spokes connect to the hub for centralized services while maintaining isolation from each other

### DNS Architecture
- **Centralized Private DNS**: Global private DNS zones managed centrally for consistency across all environments
- **DNS Forwarding**: Hub-based DNS resolver forwards queries and enables hybrid connectivity
- **Auto-Registration**: Azure Policy automatically registers private endpoints to appropriate DNS zones

### Security & Governance
- **Azure Policy**: Automatic compliance and configuration enforcement
- **Private Endpoints**: All PaaS services use private connectivity
- **Network Security**: Proper segmentation and access controls

## Project Structure

```
├── 01-hub/                # Core hub infrastructure
├── 02-auto-dns-register/  # DNS automation policies
├── 03-spoke-network/      # Spoke network infrastructure
├── 04-spoke-app/          # Application workload example
├── 05-spoke-test/         # Test environment
└── main.tf                # Root module orchestrating all components
```

## Azure Resources Overview

![hub spoke](./doc/hub-spoke.svg "Hub and Spoke")

## Features

### Implemented
- ✅ Hub-and-spoke network topology
- ✅ Centralized DNS resolution with Azure DNS Private Resolver
- ✅ Private DNS zones for Azure PaaS services
- ✅ Automatic private endpoint DNS registration via Azure Policy
- ✅ Network peering between hub and spokes
- ✅ Example workloads (storage account, test VM)

## Key Architectural Decisions

1. **Centralized DNS Management**: Private DNS zones are managed centrally to ensure consistency and avoid conflicts
2. **Policy-Driven Automation**: Azure Policy automatically configures private endpoints for compliance and operational efficiency
3. **Team Autonomy**: Spoke teams can manage their own VNets while leveraging centralized services
4. **Multi-Region Ready**: Architecture supports expansion to multiple regions
5. **Security by Default**: All PaaS services use private endpoints and network isolation

## Limitations

- **Asynchronous Policy Execution**: Azure Policy execution is asynchronous and may take several minutes to complete. Private endpoint DNS registration won't be immediate after resource creation
- **DNS Record Cleanup**: The policy handles automatic DNS record creation but does not automatically remove DNS records when private endpoints are deleted. Manual cleanup may be required

## Prerequisites

- Azure CLI installed and configured
- Terraform >= 1.1.0
- Active Azure subscription with appropriate permissions
- Contributor access to create resources and assign policies

## Quick Start

1. **Login to Azure**
   ```bash
   az login
   ```

2. **Initialize Terraform**
   ```bash
   terraform init
   ```

3. **Review and Apply**
   ```bash
   terraform plan
   terraform apply
   ```

4. **Clean Up** (when needed)
   ```bash
   terraform destroy
   ```

## Module Dependencies

```
01-hub (foundation)
├── 02-auto-dns-register (requires dns_zones output)
├── 03-spoke-network (requires vet_hub and hub_dns_ip outputs)
│   ├── 04-spoke-app (requires subnet_id output)
│   └── 05-spoke-test (requires subnet_id output)
```


## References

- [Azure DNS Private Resolver Architecture](https://learn.microsoft.com/en-us/azure/dns/private-resolver-architecture)
- [Azure Landing Zone Bicep](https://github.com/Azure/ALZ-Bicep/tree/main)
- [Private DNS Overview](https://learn.microsoft.com/en-us/azure/dns/private-dns-overview#other-considerations)
- [Private Link and DNS Integration at Scale](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/private-link-and-dns-integration-at-scale)
- [Azure Policy for Private Endpoints](https://blog.tyang.org/2023/01/26/using-azure-policy-to-create-dns-records-for-private-endpoints)
- [Private Endpoint DNS Integration](https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-dns)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.