variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
}

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "vnet_address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
}

variable "subnets" {
  description = "List of subnets to create (exactly 2 subnets expected)"
  type = list(object({
    name              = string
    address_prefixes  = list(string)
    service_endpoints = list(string)
  }))
  default = [
    {
      name              = "subneta"
      address_prefixes  = ["10.0.1.0/24"]
      service_endpoints = []
    },
    {
      name              = "subnetb"
      address_prefixes  = ["10.0.2.0/24"]
      service_endpoints = []
    }
  ]

  validation {
    condition     = length(var.subnets) == 2
    error_message = "Exactly 2 subnets must be provided."
  }
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
