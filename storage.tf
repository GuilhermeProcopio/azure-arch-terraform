resource "random_id" "random_vm1_id" {
  keepers = {
    resource_group_name = azurerm_resource_group.rg.name
  }

  byte_length = 8
}

resource "random_id" "random_vm2_id" {
  keepers = {
    resource_group_name = azurerm_resource_group.rg.name
  }
  byte_length = 8
}


resource "azurerm_storage_account" "vm1_storage_account" {
  name                     = "diag${random_id.random_vm1_id.hex}"
  location                 = azurerm_resource_group.rg.location
  resource_group_name      = azurerm_resource_group.rg.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}


resource "azurerm_storage_account" "vm2_storage_account" {
  name                     = "diag${random_id.random_vm2_id.hex}"
  location                 = azurerm_resource_group.rg.location
  resource_group_name      = azurerm_resource_group.rg.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}