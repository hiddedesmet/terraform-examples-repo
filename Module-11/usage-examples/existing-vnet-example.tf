# Example 3: Adding Subnets to Existing VNet

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# This example shows how to add subnets to an existing VNet
# This is only possible with the two-module approach

# Data source to reference an existing VNet
data "azurerm_virtual_network" "existing" {
  name                = "existing-vnet"
  resource_group_name = "existing-rg"
}

# Add subnets to the existing VNet using the subnet module
module "new_subnets" {
  source = "../two-modules/subnet-module"
  
  resource_group_name  = data.azurerm_virtual_network.existing.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.existing.name
  
  subnets = {
    new_web = {
      address_prefixes  = ["10.1.1.0/24"]
      service_endpoints = ["Microsoft.Storage"]
    }
    new_api = {
      address_prefixes  = ["10.1.2.0/24"]
      service_endpoints = ["Microsoft.Sql", "Microsoft.KeyVault"]
    }
  }
}

output "new_subnet_ids" {
  value = module.new_subnets.subnet_ids
}
