output "subnet_ids" {
  description = "Map of subnet names to their IDs"
  value       = { for k, v in azurerm_subnet.subnets : k => v.id }
}

output "subnet_names" {
  description = "Map of subnet names to their full names"
  value       = { for k, v in azurerm_subnet.subnets : k => v.name }
}

output "subnet_address_prefixes" {
  description = "Map of subnet names to their address prefixes"
  value       = { for k, v in azurerm_subnet.subnets : k => v.address_prefixes }
}

output "subnet_objects" {
  description = "Map of subnet names to their full objects"
  value       = azurerm_subnet.subnets
}
