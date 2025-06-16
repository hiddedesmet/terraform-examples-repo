# Two Module Approach: Separate VNet and Subnet Modules

This approach separates VNet and subnet creation into individual modules for better modularity and reusability.

## Modules

### VNet Module (`vnet-module/`)
Creates and manages Azure Virtual Networks.

### Subnet Module (`subnet-module/`)
Creates and manages Azure Subnets using `for_each`.

## Usage

```hcl
# Create the VNet
module "vnet" {
  source = "./two-modules/vnet-module"
  
  resource_group_name = "rg-example"
  location           = "West Europe"
  vnet_name          = "vnet-example"
  address_space      = ["10.0.0.0/16"]
  
  tags = {
    Environment = "Development"
    Project     = "Example"
  }
}

# Create subnets
module "subnets" {
  source = "./two-modules/subnet-module"
  
  resource_group_name  = "rg-example"
  virtual_network_name = module.vnet.vnet_name
  
  subnets = {
    web = {
      address_prefixes = ["10.0.1.0/24"]
      service_endpoints = ["Microsoft.Storage"]
    }
    app = {
      address_prefixes = ["10.0.2.0/24"]
      service_endpoints = ["Microsoft.Sql"]
    }
    data = {
      address_prefixes = ["10.0.3.0/24"]
      service_endpoints = []
    }
  }
  
  depends_on = [module.vnet]
}
```

## Benefits

1. **Modularity**: Each module has a single responsibility
2. **Reusability**: Can use subnet module with existing VNets
3. **Flexibility**: Can create subnets independently
4. **Testing**: Easier to test individual components
