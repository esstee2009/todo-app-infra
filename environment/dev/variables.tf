variable "rgs" {
  type = map(object({
    resource_group_name = string
    location            = string
    managed_by          = optional(string)
    tags                = optional(map(string))
  }))
}
variable "virtual_networks" {
  type = map(object({
    virtual_network_name           = string
    location                       = string
    resource_group_name            = string
    address_space                  = optional(list(string))
    dns_servers                    = optional(list(string))
    edge_zone                      = optional(string)
    flow_timeout_in_minutes        = optional(number)
    private_endpoint_vnet_policies = optional(string, "Disabled")
    tags                           = optional(map(string))
    environment                    = optional(string)

    ddos_protection_plan = optional(object({
      id     = string
      enable = bool
    }))

    subnets = optional(map(object({
      name              = string
      address_prefixes  = list(string)
      security_group_id = optional(string)
    })))
  }))
}

variable "public_ip" {
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    allocation_method   = string

    tags = map(string)
  }))
}

variable "virtual_machine" {
  type = map(object({
    vm_name                         = string
    location                        = string
    resource_group_name             = string
    size                            = string
    network_interface               = string
    subnet_name                     = string
    virtual_network_name            = string
    network_interface_ids           = optional(list(string), [])
    disable_password_authentication = bool

    admin_username = optional(string)
    admin_password = optional(string)

    ip_configuration = map(object({
      subnet_name                   = string
      private_ip_address_allocation = optional(string, "Dynamic")
      private_ip_address            = optional(string)
    }))
  }))
}

# variable "keyvault_config" {
#   type = map(object({
#     name                = string
#     location            = string
#     resource_group_name = string

#     enabled_for_disk_encryption = optional(bool, true)
#     tenant_id                   = optional(string)
#     soft_delete_retention_days  = optional(number)
#     purge_protection_enabled    = optional(bool, false)
#     sku_name                    = optional(string)

#     access_policies = optional(list(object({
#       tenant_id               = string
#       object_id               = string
#       application_id          = optional(string)
#       key_permissions         = optional(list(string), [])
#       secret_permissions      = optional(list(string), [])
#       certificate_permissions = optional(list(string), [])
#       storage_permissions     = optional(list(string), [])
#     })), [])

#     tags = optional(map(string), {})
#   }))
# }