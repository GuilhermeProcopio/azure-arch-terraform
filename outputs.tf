output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "public_ip_address" {
  value = azurerm_public_ip.public_ip.*.ip_address
}

output "bastion_public_ip_address" {
  value = azurerm_public_ip.bastion_public_ip.*.ip_address
}