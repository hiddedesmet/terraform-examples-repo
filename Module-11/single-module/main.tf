# Create the Virtual Network
resource "azurerm_virtual_network" "main" {
  name                = var.vnet_name
  address_space       = var.vnet_address_space
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.tags
}

# Create first subnet from the list
resource "azurerm_subnet" "subneta" {
  name                 = var.subnets[0].name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = var.subnets[0].address_prefixes
  service_endpoints    = var.subnets[0].service_endpoints
}

# Create second subnet from the list
resource "azurerm_subnet" "subnetb" {
  name                 = var.subnets[1].name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = var.subnets[1].address_prefixes
  service_endpoints    = var.subnets[1].service_endpoints
}
