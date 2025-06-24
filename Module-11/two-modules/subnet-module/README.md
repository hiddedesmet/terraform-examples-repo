# Azure Subnet Module

This Terraform module creates Azure subnets with optional route table and network security group associations. It supports subnet delegation, service endpoints, and flexible configuration through a map-based approach.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_subnet.subnets](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.nsg_associations](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_route_table_association.route_table_associations](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_network_security_group_associations"></a> [network\_security\_group\_associations](#input\_network\_security\_group\_associations) | Map of subnet names to network security group IDs for association | `map(string)` | `{}` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group | `string` | n/a | yes |
| <a name="input_route_table_associations"></a> [route\_table\_associations](#input\_route\_table\_associations) | Map of subnet names to route table IDs for association | `map(string)` | `{}` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | Map of subnets to create | <pre>map(object({<br/>    address_prefixes  = list(string)<br/>    service_endpoints = optional(list(string), [])<br/>    delegation = optional(object({<br/>      name = string<br/>      service_delegation = object({<br/>        name    = string<br/>        actions = list(string)<br/>      })<br/>    }))<br/>    private_endpoint_network_policies_enabled     = optional(bool, true)<br/>    private_link_service_network_policies_enabled = optional(bool, true)<br/>  }))</pre> | `{}` | no |
| <a name="input_virtual_network_name"></a> [virtual\_network\_name](#input\_virtual\_network\_name) | Name of the virtual network where subnets will be created | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_subnet_address_prefixes"></a> [subnet\_address\_prefixes](#output\_subnet\_address\_prefixes) | Map of subnet names to their address prefixes |
| <a name="output_subnet_ids"></a> [subnet\_ids](#output\_subnet\_ids) | Map of subnet names to their IDs |
| <a name="output_subnet_names"></a> [subnet\_names](#output\_subnet\_names) | Map of subnet names to their full names |
| <a name="output_subnet_objects"></a> [subnet\_objects](#output\_subnet\_objects) | Map of subnet names to their full objects |
<!-- END_TF_DOCS -->
