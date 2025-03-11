
resource "random_string" "storage_local_id" {
  length  = 4
  special = false
  upper   = false
}

resource "azurerm_storage_account" "storage_local" {
  name                     = "stalocal${random_string.storage_local_id.result}"
  resource_group_name      = azurerm_resource_group.spoke_app.name
  location                 = azurerm_resource_group.spoke_app.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}


resource "azurerm_private_endpoint" "storage_local" {
  name                = "pep-${azurerm_storage_account.storage_local.name}"
  location            = azurerm_resource_group.spoke_app.location
  resource_group_name = azurerm_resource_group.spoke_app.name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "storage-local-privateconnection"
    private_connection_resource_id = azurerm_storage_account.storage_local.id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }
}

resource "azurerm_private_dns_a_record" "storage_local" {
  name                = "storage02"
  zone_name           = var.spoke_dns_zone.name
  resource_group_name = var.spoke_dns_zone.resource_group_name
  ttl                 = 300
  records             = [azurerm_private_endpoint.storage_local.private_service_connection[0].private_ip_address]
}
