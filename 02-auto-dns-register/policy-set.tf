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


#  policy_definition_reference {
#     policy_definition_id = azurerm_policy_definition.single_dns_register.id
#     parameter_values     = <<VALUE
#     {
#       "privateDnsZoneId": {"value": "/subscriptions/9b328be6-81d2-4e90-840f-75cedf81e987/resourceGroups/rg-private-dns-zone/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net"},
#       "privateEndpointGroupId": {"value": "blob"},
#       "privateLinkServiceId": {"value": "Microsoft.Storage/storageAccounts"}
#     }
#     VALUE
#   }

#   policy_definition_reference {
#     policy_definition_id = azurerm_policy_definition.single_dns_register.id
#     parameter_values     = <<VALUE
#     {
#       "privateDnsZoneId": {"value": "/subscriptions/9b328be6-81d2-4e90-840f-75cedf81e987/resourceGroups/rg-private-dns-zone/providers/Microsoft.Network/privateDnsZones/privatelink.postgres.database.azure.com"},
#       "privateEndpointGroupId": {"value": "postgresqlServer"},
#       "privateLinkServiceId": {"value": "Microsoft.DBforPostgreSQL/flexibleServers"}
#     }
#     VALUE
#   }
