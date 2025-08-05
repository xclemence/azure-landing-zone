# 01-hub Module
**Purpose**: Creates the central hub infrastructure including networking, DNS resolver, and private DNS zones.

**Key Resources**:
- Hub Virtual Network (`10.0.0.0/16`)
- Azure DNS Private Resolver with inbound/outbound endpoints
- Private DNS zones for Azure services
- DNS forwarding ruleset

**Inputs**:
```hcl
module "hub" {
  source   = "./01-hub"
  location = "france central"
  
  private_dns_zones = {
    blob = "privatelink.blob.core.windows.net"
    postgres = "privatelink.postgres.database.azure.com"
  }
}
```

**Variables**:
- `location` (string): Azure region for deployment
- `private_dns_zones` (map): DNS zones to create (key = alias, value = zone name)

**Outputs**:
- `hub_dns_ip`: IP address of the DNS resolver for spoke configuration
- `vet_hub`: Hub VNet information for peering
- `dns_zones`: Created DNS zones information
