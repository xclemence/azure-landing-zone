# Azure Landing Zone

The goal of this project is to deploy a landing zone on Azure that meets the following requirements:
- Isolation between projects (spoke model)
- Autonomous projects (self-service creation of Azure PaaS services)
- Alignment with Microsoft best practices

## Considerations

- VNet management can be delegated to project teams (spoke management); only the VNet address space should be managed by central teams.
- Azure offers a new service for address space allocation to teams, but it is not tested in this project.
- The private DNS zone should be global across all spokes and cannot be managed by spoke teams.

## Architecture Decisions
- Use a hub and spoke organization for project isolation and to allow teams to be autonomous
  - Each spoke has a dedicated VNet; team members can manage their own VNet
- Use a **centralized DNS architecture** to allow multi-region support
- Use Azure Policy to auto-register private endpoints to Azure Private DNS Zones

## Azure Organization

![hub spoke](./doc/hub-spoke.svg "Hub and Spoke")

## Terraform

### Tools
- Terraform
- Azure CLI
- Azure subscription

### How to Run Scripts

```sh
az login
```

```sh
terraform init
```

```sh
terraform apply
```

## Links
- https://learn.microsoft.com/en-us/azure/dns/private-resolver-architecture
- https://github.com/Azure/ALZ-Bicep/tree/main
- https://learn.microsoft.com/en-us/azure/dns/private-dns-overview#other-considerations
- https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/private-link-and-dns-integration-at-scale
- https://blog.tyang.org/2023/01/26/using-azure-policy-to-create-dns-records-for-private-endpoints
- https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-dns

