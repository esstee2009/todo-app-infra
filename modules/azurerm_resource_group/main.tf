resource "azurerm_resource_group" "rgs" {
  for_each = var.rgs
  name     = each.value.resource_group_name
  location = each.value.location
  managed_by = each.value.managed_by
  tags = each.value.tags
  }