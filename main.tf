locals {
  dns_zones = {
    blob = {
      groupId       = "blob"
      name          = "privatelink.blob.core.windows.net"
      linkServiceId = "Microsoft.Storage/storageAccounts"
    }
    postgres = {
      groupId       = "postgresqlServer"
      name          = "privatelink.postgres.database.azure.com"
      linkServiceId = "Microsoft.DBforPostgreSQL/flexibleServers"
    }
  }

  location = "france central"
}


module "hub" {
  source   = "./01-hub"
  location = local.location

  private_dns_zones = {
    for zone_key, zone in local.dns_zones :
    zone_key => zone.name
  }
}


module "auto-dns-register" {
  source = "./02-auto-dns-register"

  identity_location = local.location
  dns_zone_configs = {
    for zone_key, zone in local.dns_zones :
    zone_key => {
      privateDnsZoneId       = module.hub.dns_zones[zone_key].id
      privateEndpointGroupId = zone.groupId
      privateLinkServiceId   = zone.linkServiceId
    }
  }
}


module "spoke" {
  source     = "./03-spoke-network"
  vet_hub    = module.hub.vet_hub
  hub_dns_ip = module.hub.hub_dns_ip
  location   = local.location
}

module "app" {
  source    = "./04-spoke-app"
  subnet_id = module.spoke.subnet_id
  dns_zones = module.hub.dns_zones
  location  = module.spoke.location
}



module "test" {
  source    = "./05-spoke-test"
  subnet_id = module.spoke.subnet_id
  location  = module.spoke.location
}


