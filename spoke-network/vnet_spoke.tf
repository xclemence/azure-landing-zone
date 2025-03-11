
resource "azurerm_resource_group" "spoke" {
  name     = "poc-lz-spoke-01"
  location = var.location
}

resource "azurerm_virtual_network" "spoke" {
  name                = "spoke-network-eu"
  location            = azurerm_resource_group.spoke.location
  resource_group_name = azurerm_resource_group.spoke.name
  address_space       = ["10.1.0.0/16"]

  tags = {
    environment = "Prototype"
  }
}


resource "azurerm_subnet" "spoke_default" {
  name                 = "default"
  resource_group_name  = azurerm_resource_group.spoke.name
  virtual_network_name = azurerm_virtual_network.spoke.name
  address_prefixes     = ["10.1.0.0/24"]
}


resource "azurerm_virtual_network_peering" "hub_to_spoke" {
  name                         = "hub_to_spoke"
  resource_group_name          = var.vet_hub.resource_group_name
  virtual_network_name         = var.vet_hub.name
  remote_virtual_network_id    = azurerm_virtual_network.spoke.id
  allow_virtual_network_access = true

}

resource "azurerm_virtual_network_peering" "spoke_to_hub" {
  name                         = "spoke_to_hub"
  resource_group_name          = azurerm_resource_group.spoke.name
  virtual_network_name         = azurerm_virtual_network.spoke.name
  remote_virtual_network_id    = var.vet_hub.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true

  depends_on = [azurerm_virtual_network_peering.hub_to_spoke]
}

resource "azurerm_virtual_network_dns_servers" "example" {
  virtual_network_id = azurerm_virtual_network.spoke.id
  dns_servers        = [var.hub_dns_ip]
}

resource "azurerm_private_dns_zone" "spoke" {
  name                = "spoke.xce.com"
  resource_group_name = azurerm_resource_group.spoke.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "spoke" {
  name                  = "spoke-link"
  resource_group_name   = azurerm_resource_group.spoke.name
  private_dns_zone_name = azurerm_private_dns_zone.spoke.name
  virtual_network_id    = var.vet_hub.id
}

