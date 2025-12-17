data "azurerm_subnet" "subnet" {
  for_each             = var.virtual_machine
  name                 = each.value.subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}

resource "azurerm_network_interface" "nic" {
  for_each            = var.virtual_machine
  name                = each.value.network_interface
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  dynamic "ip_configuration" {
    for_each = each.value.ip_configuration
    content {
      name                          = ip_configuration.key
      subnet_id                     = data.azurerm_subnet.subnet[each.key].id
      private_ip_address_allocation = lookup(ip_configuration.value, "private_ip_address_allocation")
      private_ip_address            = lookup(ip_configuration.value, "private_ip_address", null)
    }
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  for_each = var.virtual_machine

  name                = each.value.vm_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  size                = each.value.size

  admin_username                  = each.value.admin_username
  admin_password                  = each.value.admin_password
  disable_password_authentication = each.value.disable_password_authentication

  custom_data = base64encode(file("${path.module}/${each.value.script_name}"))

  network_interface_ids = [azurerm_network_interface.nic[each.key].id]

  os_disk {
    caching              = each.value.os_disk_caching
    storage_account_type = each.value.storage_account_type
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

tags = lookup(each.value, "tags", {})
}
