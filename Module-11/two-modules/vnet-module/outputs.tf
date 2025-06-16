output "vnet_id" {
  description = "The ID of the virtual network"
  value       = azurerm_virtual_network.main.id
}

output "vnet_name" {
  description = "The name of the virtual network"
  value       = azurerm_virtual_network.main.name
}

output "vnet_address_space" {
  description = "The address space of the virtual network"
  value       = azurerm_virtual_network.main.address_space
}

output "vnet_location" {
  description = "The location of the virtual network"
  value       = azurerm_virtual_network.main.location
}

output "vnet_resource_group_name" {
  description = "The resource group name of the virtual network"
  value       = azurerm_virtual_network.main.resource_group_name
}
