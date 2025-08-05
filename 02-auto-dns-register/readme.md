# 02-auto-dns-register Module

**Purpose**: Implements Azure Policy for automatic DNS registration of private endpoints.

**Location**: [02-auto-dns-register/](02-auto-dns-register/)

**Key Resources**:
- Custom Azure Policy definition for DNS registration
- Policy set combining multiple DNS policies
- Subscription-level policy assignment with managed identity
- Role assignment for Network Contributor permissions

**Inputs**:
```hcl
module "auto-dns-register" {
  source = "./02-auto-dns-register"
  
  identity_location = "france central"
  dns_zone_configs = {
    blob = {
      privateDnsZoneId       = "/subscriptions/.../privateDnsZones/privatelink.blob.core.windows.net"
      privateEndpointGroupId = "blob"
      privateLinkServiceId   = "Microsoft.Storage/storageAccounts"
    }
  }
}
```

**Variables**:
- `identity_location` (string): Location for managed identity
- `dns_zone_configs` (map): Configuration for each DNS zone policy

**Policy Template**: Based on [doc/base-policy.json](doc/base-policy.json)
