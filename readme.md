# Azure Landing Zone

## Requirements
Main requirements used for project design:
- Isolation between projects (spoke)
- Autonomous projects (self-service for Azure service creation)
- Respect best practices from Microsoft
- Support multi-regions for spoke VNet

## Azure Organisation

![hub spoke](./doc/hub-spoke.svg "Hub and Spoke")

## Terraform 

### Tool
- Terraform
- Azure CLI
- Azure subscription

### How to run Scripts

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
- https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-dns
- https://github.com/Azure/ALZ-Bicep/tree/main
