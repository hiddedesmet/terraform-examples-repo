variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "virtual_network_name" {
  description = "Name of the virtual network where subnets will be created"
  type        = string
}

variable "subnets" {
  description = "Map of subnets to create"
  type = map(object({
    address_prefixes  = list(string)
    service_endpoints = optional(list(string), [])
    delegation = optional(object({
      name = string
      service_delegation = object({
        name    = string
        actions = list(string)
      })
    }))
    private_endpoint_network_policies_enabled     = optional(bool, true)
    private_link_service_network_policies_enabled = optional(bool, true)
  }))
  default = {}
}

variable "route_table_associations" {
  description = "Map of subnet names to route table IDs for association"
  type        = map(string)
  default     = {}
}

variable "network_security_group_associations" {
  description = "Map of subnet names to network security group IDs for association"
  type        = map(string)
  default     = {}
}
