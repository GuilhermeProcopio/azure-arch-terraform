# resource "azurerm_network_interface" "vm2_nic" {
#   name                = "nic-vm2"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name

#   ip_configuration {
#     name                          = "nic2-config"  # O nome da configuração de IP é "nic2-config"
#     subnet_id                     = azurerm_subnet.subnet.id
#     private_ip_address_allocation = "Dynamic"
#   }
# }

# # Address pool
# resource "azurerm_network_interface_backend_address_pool_association" "nic2_address_pool" {
#   network_interface_id    = azurerm_network_interface.vm2_nic.id
#   ip_configuration_name   = "nic2-config"  # Corrigido para "nic2-config"
#   backend_address_pool_id = azurerm_lb_backend_address_pool.lb_backend_pool.id
# }

# resource "azurerm_network_interface_security_group_association" "nsg_nic2" {
#   network_interface_id      = azurerm_network_interface.vm2_nic.id
#   network_security_group_id = azurerm_network_security_group.nsg.id
# }

# resource "azurerm_linux_virtual_machine" "vm2" {
#   name                  = "linux-vm2"
#   location              = azurerm_resource_group.rg.location
#   resource_group_name   = azurerm_resource_group.rg.name
#   network_interface_ids = [azurerm_network_interface.vm2_nic.id]
#   size                  = "Standard_DS1_v2"

#   os_disk {
#     name                 = "vm2-disk"
#     caching              = "ReadWrite"
#     storage_account_type = "StandardSSD_LRS"
#   }

#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "0001-com-ubuntu-server-jammy"
#     sku       = "22_04-lts-gen2"
#     version   = "latest"
#   }

#   computer_name  = "vm2"
#   admin_username = var.vm_user

#   admin_ssh_key {
#     username   = var.vm_user
#     public_key = azapi_resource_action.ssh_public_key_gen.output.publicKey
#   }

#   boot_diagnostics {
#     storage_account_uri = azurerm_storage_account.vm2_storage_account.primary_blob_endpoint
#   }
# }
