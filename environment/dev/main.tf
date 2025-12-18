module "resource_group" {
  source = "../../modules/azurerm_resource_group"
  rgs    = var.rgs
}

module "network" {
  depends_on       = [module.resource_group]
  source           = "../../modules/azurerm_networking"
  virtual_networks = var.virtual_networks
}

module "pip" {
  depends_on = [module.network]
  source     = "../../modules/azurerm_public_ip"
  public_ip  = var.public_ip
}

module "vm" {
  depends_on      = [module.network, module.pip]
  source          = "../../modules/azurerm_compute"
  virtual_machine = var.virtual_machine
}

# module "kv" {
#   source          = "../../modules/azurerm_key_vault"
#   depends_on = [ module.network ]
#   keyvault_config = var.keyvault_config
# }