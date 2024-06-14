resource "random_pet" "rg_name" {
  prefix = var.resource_group_name_prefix
}

resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = random_pet.rg_name
}

resource "azurerm_virtual_network" "vnet" {
  name                = "default-vnet"
  address_space       = ["10.1.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "default-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.1.0.0/24"]
}

resource "azurerm_public_ip" "public_ip" {
  name                = "default-public-ip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1", "2", "3"]
}

resource "azurerm_lb" "load_bancer" {
  name                = "default-lb"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"

frontend_ip_configuration {
  name                 = "deafult-frontend-ip"
  public_ip_address_id = azurerm_public_ip.public_ip.id
} 
}

resource "azurerm_lb_backend_address_pool" "lb_backend_pool" {
  loadbalancer_id = azurerm_lb.load_bancer.id
  name = "lb-backendpool"
}

resource "azurerm_lb_probe" "lb_probe" {
  loadbalancer_id = azurerm_lb.load_bancer.id
  name = "lb-health-probe"
  port = 80
  protocol = "Tcp"
}

