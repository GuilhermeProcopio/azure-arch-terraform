output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "public_ip_address" {
  value = azurerm_public_ip.public_ip.*.ip_address
}

output "bastion_public_ip_address" {
  value = azurerm_public_ip.bastion_public_ip.*.ip_address
}

output "vm1_private_ip_address" {
  value = azurerm_linux_virtual_machine.vm1.private_ip_address
}


output "vm2_private_ip_address" {
  value = azurerm_linux_virtual_machine.vm2.private_ip_address
}