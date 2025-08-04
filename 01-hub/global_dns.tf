resource "azurerm_resource_group" "dns_zone" {
  name     = "poc-lz-dns-zones"
  location = var.location
}

# Création dynamique des zones DNS privées
resource "azurerm_private_dns_zone" "zones" {
  for_each = var.private_dns_zones
  
  name                = each.value
  resource_group_name = azurerm_resource_group.dns_zone.name
}

# Association dynamique des zones DNS avec le VNet Hub
resource "azurerm_private_dns_zone_virtual_network_link" "zones_links" {
  for_each = var.private_dns_zones
  
  name                  = "${each.key}-link"
  resource_group_name   = azurerm_resource_group.dns_zone.name
  private_dns_zone_name = azurerm_private_dns_zone.zones[each.key].name
  virtual_network_id    = azurerm_virtual_network.hub.id
}
