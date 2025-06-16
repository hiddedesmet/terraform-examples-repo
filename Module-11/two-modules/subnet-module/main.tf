# Create subnets using for_each
resource "azurerm_subnet" "subnets" {
  for_each = var.subnets

  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = each.value.address_prefixes
  service_endpoints    = each.value.service_endpoints

  # Optional delegation block
  dynamic "delegation" {
    for_each = each.value.delegation != null ? [each.value.delegation] : []
    content {
      name = delegation.value.name
      service_delegation {
        name    = delegation.value.service_delegation.name
        actions = delegation.value.service_delegation.actions
      }
    }
  }
}

# Optional route table associations
resource "azurerm_subnet_route_table_association" "route_table_associations" {
  for_each = var.route_table_associations

  subnet_id      = azurerm_subnet.subnets[each.key].id
  route_table_id = each.value
}

# Optional network security group associations
resource "azurerm_subnet_network_security_group_association" "nsg_associations" {
  for_each = var.network_security_group_associations

  subnet_id                 = azurerm_subnet.subnets[each.key].id
  network_security_group_id = each.value
}
