# Example 1: Using Single Module Approach

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

# Resource Group
resource "azurerm_resource_group" "example" {
  name     = "rg-single-module-example"
  location = "West Europe"
}

# Single module that creates VNet and two subnets from a predefined list
module "network" {
  source = "../single-module"
  
  resource_group_name = azurerm_resource_group.example.name
  location           = azurerm_resource_group.example.location
  vnet_name          = "vnet-single-example"
  vnet_address_space = ["10.0.0.0/16"]
  
  # Override the default subnet list
  subnets = [
    {
      name              = "web-subnet"
      address_prefixes  = ["10.0.1.0/24"]
      service_endpoints = ["Microsoft.Storage", "Microsoft.KeyVault"]
    },
    {
      name              = "app-subnet"
      address_prefixes  = ["10.0.2.0/24"]
      service_endpoints = ["Microsoft.Sql"]
    }
  ]
  
  tags = {
    Environment = "Development"
    Project     = "Single-Module-Example"
    CreatedBy   = "Terraform"
  }
}

# Example using default subnets
module "network_default" {
  source = "../single-module"
  
  resource_group_name = azurerm_resource_group.example.name
  location           = azurerm_resource_group.example.location
  vnet_name          = "vnet-default-example"
  vnet_address_space = ["10.1.0.0/16"]
  
  # Will use default subnets: subneta and subnetb
  
  tags = {
    Environment = "Development"
    Project     = "Default-Subnets-Example"
    CreatedBy   = "Terraform"
  }
}

# Outputs to demonstrate what we get
output "vnet_id" {
  value = module.network.vnet_id
}

output "first_subnet_id" {
  value = module.network.first_subnet_id
}

output "first_subnet_name" {
  value = module.network.first_subnet_name
}

output "second_subnet_id" {
  value = module.network.second_subnet_id
}

output "second_subnet_name" {
  value = module.network.second_subnet_name
}
