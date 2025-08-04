data "azurerm_subscription" "current" {}

resource "azurerm_subscription_policy_assignment" "dns_register" {
  name                 = "dns-auto-register"
  policy_definition_id = azurerm_policy_set_definition.dns_register.id
  subscription_id      = data.azurerm_subscription.current.id
  location             = "francecentral"

  identity {
    type = "SystemAssigned"
  }
}

# Attribution du rôle Network Contributor à l'identité managée de la politique
resource "azurerm_role_assignment" "dns_register_network_contributor" {
  scope              = data.azurerm_subscription.current.id
  role_definition_id = "/subscriptions/${data.azurerm_subscription.current.subscription_id}/providers/Microsoft.Authorization/roleDefinitions/4d97b98b-1d4f-4787-a291-c67834d212e7"
  principal_id       = azurerm_subscription_policy_assignment.dns_register.identity[0].principal_id

  depends_on = [azurerm_subscription_policy_assignment.dns_register]
}
