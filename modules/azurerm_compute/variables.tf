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