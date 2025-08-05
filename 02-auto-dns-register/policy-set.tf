resource "azurerm_policy_set_definition" "dns_register" {
  name         = "private-dns-register"
  policy_type  = "Custom"
  display_name = "Private DNS Register"

  dynamic "policy_definition_reference" {
    for_each = var.dns_zone_configs

    content {
      policy_definition_id = azurerm_policy_definition.single_dns_register.id
      parameter_values = jsonencode({
        privateDnsZoneId = {
          value = policy_definition_reference.value.privateDnsZoneId
        }
        privateEndpointGroupId = {
          value = policy_definition_reference.value.privateEndpointGroupId
        }
        privateLinkServiceId = {
          value = policy_definition_reference.value.privateLinkServiceId
        }
      })
    }
  }
}
