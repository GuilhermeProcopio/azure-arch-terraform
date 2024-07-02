resource "azurerm_network_interface" "vm_nic" {
  count               = 2
  name                = "nic-vm-${count.index}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "nic-${count.index}-config" # O nome da configuração de IP é "nic1-config"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Address pool
resource "azurerm_network_interface_backend_address_pool_association" "nic_address_pool" {
  count                   = 2
  network_interface_id    = azurerm_network_interface.vm_nic[count.index].id
  ip_configuration_name   = "nic-${count.index}-config"
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb_backend_pool.id
}

resource "azurerm_network_interface_security_group_association" "nsg_nic" {
  count                     = 2
  network_interface_id      = azurerm_network_interface.vm_nic[count.index].id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_linux_virtual_machine" "vm" {
  count                 = 2
  name                  = "linux-vm-${count.index}"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.vm_nic[count.index].id]
  size                  = "Standard_DS1_v2"
  depends_on            = [azurerm_network_interface.vm_nic]

  os_disk {
    name                 = "vm-disk"
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  computer_name = "vm-${count.index}"

  admin_username = var.vm_user

  admin_ssh_key {
    username   = var.vm_user
    public_key = azapi_resource_action.ssh_public_key_gen.output.publicKey
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.vm1_storage_account.primary_blob_endpoint
  }
}