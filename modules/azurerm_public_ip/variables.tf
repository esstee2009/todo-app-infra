variable "public_ip" {
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    allocation_method   = string

    tags                 = optional(map(string), {})
    ddos_protection_mode = optional(string)
    domain_name_label    = optional(string, null)
  }))
}