module "hub" {
  source   = "./hub"
  location = "france central"
}

module "spoke" {
  source     = "./spoke-network"
  vet_hub    = module.hub.vet_hub
  hub_dns_ip = module.hub.hub_dns_ip
  location   = "france central"
}

module "app" {
  source         = "./spoke-app"
  subnet_id      = module.spoke.subnet_id
  dns_zones      = module.hub.dns_zones
  location       = module.spoke.location
  spoke_dns_zone = module.spoke.dns_zone
}

module "test" {
  source    = "./spoke-test"
  subnet_id = module.spoke.subnet_id
  location  = module.spoke.location
}
