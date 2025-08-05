# 04-spoke-app Module
**Purpose**: Example application workload with private endpoint connectivity.

**Key Resources**:
- Resource group for application resources
- Storage account with private endpoint
- Commented web application example

**Inputs**:
```hcl
module "app" {
  source    = "./04-spoke-app"
  subnet_id = module.spoke.subnet_id
  dns_zones = module.hub.dns_zones
  location  = "france central"
}
```

**Variables**:
- `location` (string): Azure region for deployment
- `subnet_id` (string): Subnet for private endpoint deployment
- `dns_zones` (map): DNS zones for private endpoint registration

**Example Usage**: Demonstrates automatic DNS registration via Azure Policy
