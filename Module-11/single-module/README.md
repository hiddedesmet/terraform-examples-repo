# Single Module Approach: VNet with Subnets

This approach combines VNet and subnet creation in a single module using `for_each`.

## Usage

```hcl
module "network" {
  source = "./single-module"
  
  resource_group_name = "rg-example"
  location           = "West Europe"
  vnet_name          = "vnet-example"
  vnet_address_space = ["10.0.0.0/16"]
  
  # Optional: Override the default subnet list
  subnets = [
    {
      name              = "web-subnet"
      address_prefixes  = ["10.0.1.0/24"]
      service_endpoints = ["Microsoft.Storage"]
    },
    {
      name              = "app-subnet"
      address_prefixes  = ["10.0.2.0/24"]
      service_endpoints = ["Microsoft.Sql"]
    }
  ]
  
  tags = {
    Environment = "Development"
    Project     = "Example"
  }
}

# Or use with default subnets (subneta and subnetb):
module "network_default" {
  source = "./single-module"
  
  resource_group_name = "rg-example"
  location           = "West Europe"
  vnet_name          = "vnet-example"
  vnet_address_space = ["10.0.0.0/16"]
  
  # subnets variable will use default values
}
```

## Outputs

- `vnet_id` - The ID of the created VNet
- `vnet_name` - The name of the created VNet
- `first_subnet_id` - The ID of the first subnet
- `first_subnet_name` - The name of the first subnet
- `second_subnet_id` - The ID of the second subnet
- `second_subnet_name` - The name of the second subnet
