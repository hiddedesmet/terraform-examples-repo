output "vnet_id" {
  description = "The ID of the virtual network"
  value       = azurerm_virtual_network.main.id
}

output "vnet_name" {
  description = "The name of the virtual network"
  value       = azurerm_virtual_network.main.name
}

output "first_subnet_id" {
  description = "The ID of the first subnet"
  value       = azurerm_subnet.subneta.id
}

output "first_subnet_name" {
  description = "The name of the first subnet"
  value       = azurerm_subnet.subneta.name
}

output "second_subnet_id" {
  description = "The ID of the second subnet"
  value       = azurerm_subnet.subnetb.id
}

output "second_subnet_name" {
  description = "The name of the second subnet"
  value       = azurerm_subnet.subnetb.name
}
