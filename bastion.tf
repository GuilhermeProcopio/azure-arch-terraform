resource "azurerm_public_ip" "bastion_public_ip" {
  name = "bastion-public-ip"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method = "Static"
  sku = "standard"
  zones = ["1", "2", "3"]
}

resource "azurerm_subnet" "bastion_subnet" {
  name = "bastion-subnet"
  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes = ["10.1.1.0/27"]
}

resource "azurerm_bastion_host" "bastion_host" {
    name = "bastion-host"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    sku = "Standard"
    tunneling_enabled = "true"

    ip_configuration {
      name = "bastion-ipconfig"
      subnet_id = azurerm_subnet.bastion_subnet.id
      public_ip_address_id = azurerm_public_ip.bastion_public_ip.id
    }
}