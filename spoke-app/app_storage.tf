
resource "random_string" "random_id" {
  length  = 4
  special = false
  upper   = false
}

resource "azurerm_storage_account" "storage" {
  name                     = "stgstorage${random_string.random_id.result}"
  resource_group_name      = azurerm_resource_group.spoke_app.name
  location                 = azurerm_resource_group.spoke_app.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}


resource "azurerm_private_endpoint" "storage" {
  name                = "pep-${azurerm_storage_account.storage.name}"
  location            = azurerm_resource_group.spoke_app.location
  resource_group_name = azurerm_resource_group.spoke_app.name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "storage-privateconnection"
    private_connection_resource_id = azurerm_storage_account.storage.id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "dns-group-sta"
    private_dns_zone_ids = [var.dns_zones["blob"].id]
  }
}

