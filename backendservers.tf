resource "azurerm_network_interface" "vm1_nic" {
  name                = "nic-vm1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "nic1-config"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "vm2_nic" {
  name                = "nic-vm2"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "nic2_config"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Address pool
resource "azurerm_network_interface_backend_address_pool_association" "nic1_address_pool" {
  network_interface_id    = azurerm_network_interface.vm1_nic.id
  ip_configuration_name   = "nic1-address-pool"
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb_backend_pool.id
}

resource "azurerm_network_interface_backend_address_pool_association" "nic2_address_pool" {
  network_interface_id    = azurerm_network_interface.vm2_nic.id
  ip_configuration_name   = "nic2-address-pool"
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb_backend_pool.id
}

resource "azurerm_network_interface_security_group_association" "nsg_nic1" {
  network_interface_id = azurerm_network_interface.vm1_nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_network_interface_security_group_association" "nsg_nic2" {
  network_interface_id = azurerm_network_interface.vm2_nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

