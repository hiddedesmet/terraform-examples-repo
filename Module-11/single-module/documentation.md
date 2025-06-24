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
| [azurerm_subnet.subneta](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.subnetb](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_virtual_network.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | Azure region where resources will be created | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group | `string` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | List of subnets to create (exactly 2 subnets expected) | <pre>list(object({<br/>    name              = string<br/>    address_prefixes  = list(string)<br/>    service_endpoints = list(string)<br/>  }))</pre> | <pre>[<br/>  {<br/>    "address_prefixes": [<br/>      "10.0.1.0/24"<br/>    ],<br/>    "name": "subneta",<br/>    "service_endpoints": []<br/>  },<br/>  {<br/>    "address_prefixes": [<br/>      "10.0.2.0/24"<br/>    ],<br/>    "name": "subnetb",<br/>    "service_endpoints": []<br/>  }<br/>]</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to all resources | `map(string)` | `{}` | no |
| <a name="input_vnet_address_space"></a> [vnet\_address\_space](#input\_vnet\_address\_space) | Address space for the virtual network | `list(string)` | n/a | yes |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | Name of the virtual network | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_first_subnet_id"></a> [first\_subnet\_id](#output\_first\_subnet\_id) | The ID of the first subnet |
| <a name="output_first_subnet_name"></a> [first\_subnet\_name](#output\_first\_subnet\_name) | The name of the first subnet |
| <a name="output_second_subnet_id"></a> [second\_subnet\_id](#output\_second\_subnet\_id) | The ID of the second subnet |
| <a name="output_second_subnet_name"></a> [second\_subnet\_name](#output\_second\_subnet\_name) | The name of the second subnet |
| <a name="output_vnet_id"></a> [vnet\_id](#output\_vnet\_id) | The ID of the virtual network |
| <a name="output_vnet_name"></a> [vnet\_name](#output\_vnet\_name) | The name of the virtual network |
<!-- END_TF_DOCS -->