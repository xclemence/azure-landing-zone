# 05-spoke-test Module
**Purpose**: Test environment with a Linux VM for connectivity validation.

**Location**: [05-spoke-test/](05-spoke-test/)

**Key Resources**:
- Linux Ubuntu VM with public IP
- Network Security Group with SSH access
- Auto-shutdown schedule
- Generated password (stored in Terraform state)

**Inputs**:
```hcl
module "test" {
  source    = "./05-spoke-test"
  subnet_id = module.spoke.subnet_id
  location  = "france central"
}
```

**Variables**:
- `subnet_id` (string): Subnet for VM deployment
- `location` (string): Azure region for deployment

**Outputs**:
- `vm_password` (sensitive): Generated VM password

**Security Note**: Uses password authentication for development purposes only
