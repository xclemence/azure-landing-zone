resource "azurerm_resource_group" "spoke_app" {
  name     = "poc-lz-app-01"
  location = var.location
}
