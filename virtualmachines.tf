resource "azurerm_linux_virtual_machine" "vm1" {
  name                  = "linux-vm1"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.vm1_nic.id]
  size                  = "Standard_DS1_v2"

  os_disk {
    name                 = "vm1-disk"
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04_lts_gen2"
    version   = "latest"
  }

  computer_name  = "vm1"
  admin_username = var.vm_user

  admin_ssh_key {
    username   = var.vm_user
    public_key = azapi_resource_action.ssh_public_key_gen.output.public_key
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.vm1_storage_account.primary_blob_endpoint
  }
}


# creates VM2

resource "azurerm_linux_virtual_machine" "vm2" {
  name                  = "linux-vm2"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.vm1_nic.id]
  size                  = "Standard_DS1_v2"

  os_disk {
    name                 = "vm2-disk"
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04_lts_gen2"
    version   = "latest"
  }

  computer_name  = "vm2"
  admin_username = var.vm_user

  admin_ssh_key {
    username   = var.vm_user
    public_key = azapi_resource_action.ssh_public_key_gen.output.public_key
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.vm2_storage_account.primary_blob_endpoint
  }
}