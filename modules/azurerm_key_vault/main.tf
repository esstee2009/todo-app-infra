data "azurerm_client_config" "kv" {}

resource "azurerm_key_vault" "k_vault" {
  for_each = var.keyvault_config

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  tenant_id = lookup(each.value, "tenant_id", data.azurerm_client_config.kv.tenant_id)

  sku_name                    = lookup(each.value, "sku_name")
  enabled_for_disk_encryption = lookup(each.value, "enabled_for_disk_encryption")
  soft_delete_retention_days  = lookup(each.value, "soft_delete_retention_days")

purge_protection_enabled = lookup(each.value, "purge_protection_enabled")

  dynamic "access_policy" {
    for_each = lookup(each.value, "access_policies", [])
    content {
      tenant_id = access_policy.value.tenant_id
      object_id = access_policy.value.object_id

      application_id = lookup(access_policy.value, "application_id", [])

      key_permissions         = lookup(access_policy.value, "key_permissions", [])
      secret_permissions      = lookup(access_policy.value, "secret_permissions", [])
      certificate_permissions = lookup(access_policy.value, "certificate_permissions", [])
      storage_permissions     = lookup(access_policy.value, "storage_permissions", [])
    }
  }

  tags = lookup(each.value, "tags", {})
}