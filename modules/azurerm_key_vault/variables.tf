variable "keyvault_config" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string

    enabled_for_disk_encryption = optional(bool, true)
    tenant_id                   = optional(string)
    soft_delete_retention_days  = optional(number)
    purge_protection_enabled    = optional(bool, false)
    sku_name                    = optional(string)

    access_policies = optional(list(object({
      tenant_id               = string
      object_id               = string
      application_id          = optional(string)
      key_permissions         = optional(list(string), [])
      secret_permissions      = optional(list(string), [])
      certificate_permissions = optional(list(string), [])
      storage_permissions     = optional(list(string), [])
    })), [])

    tags = optional(map(string), {})
  }))
}