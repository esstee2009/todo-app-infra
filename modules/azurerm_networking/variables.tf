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
