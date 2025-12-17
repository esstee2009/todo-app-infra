resource "azurerm_public_ip" "pip" {
  for_each            = var.public_ip
  name                = lookup(each.value, "name", "pip-${each.key}")
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  allocation_method   = each.value.allocation_method

  tags = each.value.tags

  ddos_protection_mode = lookup(each.value, "ddos_protection_mode", null)

  domain_name_label = lookup(each.value, "domain_name_label", null)
}