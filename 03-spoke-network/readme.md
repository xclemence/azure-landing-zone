# 03-spoke-network Module
**Purpose**: Creates spoke virtual networks with hub connectivity and DNS configuration.

**Location**: [03-spoke-network/](03-spoke-network/)

**Key Resources**:
- Spoke Virtual Network (`10.1.0.0/16`)
- Default subnet for workloads
- Bidirectional VNet peering with hub
- DNS server configuration pointing to hub

**Inputs**:
```hcl
module "spoke" {
  source     = "./03-spoke-network"
  vet_hub    = module.hub.vet_hub
  hub_dns_ip = module.hub.hub_dns_ip
  location   = "france central"
}
```

**Variables**:
- `location` (string): Azure region for deployment
- `hub_dns_ip` (string): DNS resolver IP from hub
- `vet_hub` (object): Hub VNet information for peering

**Outputs**:
- `subnet_id`: Default subnet ID for workload deployment
- `location`: Deployment location