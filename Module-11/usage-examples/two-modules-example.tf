# Example 2: Using Two Module Approach

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
  name     = "rg-two-modules-example"
  location = "West Europe"
}

# Step 1: Create the VNet using the VNet module
module "vnet" {
  source = "../two-modules/vnet-module"
  
  resource_group_name = azurerm_resource_group.example.name
  location           = azurerm_resource_group.example.location
  vnet_name          = "vnet-two-modules-example"
  address_space      = ["10.0.0.0/16"]
  
  tags = {
    Environment = "Development"
    Project     = "Two-Modules-Example"
    CreatedBy   = "Terraform"
  }
}

# Step 2: Create subnets using the subnet module
module "subnets" {
  source = "../two-modules/subnet-module"
  
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = module.vnet.vnet_name
  
  subnets = {
    web = {
      address_prefixes  = ["10.0.1.0/24"]
      service_endpoints = ["Microsoft.Storage", "Microsoft.KeyVault"]
    }
    app = {
      address_prefixes  = ["10.0.2.0/24"]
      service_endpoints = ["Microsoft.Sql"]
    }
    data = {
      address_prefixes  = ["10.0.3.0/24"]
      service_endpoints = []
    }
    # Example with delegation for Azure Container Instances
    aci = {
      address_prefixes  = ["10.0.4.0/24"]
      service_endpoints = []
      delegation = {
        name = "aci-delegation"
        service_delegation = {
          name    = "Microsoft.ContainerInstance/containerGroups"
          actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
        }
      }
    }
  }
  
  depends_on = [module.vnet]
}

# Optional: Add more subnets later (this shows the flexibility)
module "additional_subnets" {
  source = "../two-modules/subnet-module"
  
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = module.vnet.vnet_name
  
  subnets = {
    management = {
      address_prefixes  = ["10.0.5.0/24"]
      service_endpoints = ["Microsoft.Storage"]
    }
    gateway = {
      address_prefixes  = ["10.0.6.0/24"]
      service_endpoints = []
    }
  }
  
  depends_on = [module.vnet, module.subnets]
}

# Outputs to demonstrate what we get
output "vnet_id" {
  value = module.vnet.vnet_id
}

output "initial_subnet_ids" {
  value = module.subnets.subnet_ids
}

output "additional_subnet_ids" {
  value = module.additional_subnets.subnet_ids
}

output "all_subnet_ids" {
  value = merge(
    module.subnets.subnet_ids,
    module.additional_subnets.subnet_ids
  )
}
