# Example 1: Basic enum-like behavior using validation
variable "environment" {
  description = "The deployment environment"
  type        = string
  default     = "dev"

  validation {
    condition = contains(["dev", "test", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, test, staging, prod."
  }
}

# Example 2: VM size with validation (similar to Azure VM SKUs)
variable "vm_size" {
  description = "The size of the virtual machine"
  type        = string
  default     = "Standard_B2s"

  validation {
    condition = contains([
      "Standard_B1s",
      "Standard_B2s", 
      "Standard_B4ms",
      "Standard_D2s_v3",
      "Standard_D4s_v3",
      "Standard_F2s_v2",
      "Standard_F4s_v2"
    ], var.vm_size)
    error_message = "VM size must be one of the supported SKUs: Standard_B1s, Standard_B2s, Standard_B4ms, Standard_D2s_v3, Standard_D4s_v3, Standard_F2s_v2, Standard_F4s_v2."
  }
}

# Example 3: Database tier with validation
variable "database_tier" {
  description = "The performance tier for the database"
  type        = string
  default     = "basic"

  validation {
    condition = contains(["basic", "standard", "premium"], var.database_tier)
    error_message = "Database tier must be one of: basic, standard, premium."
  }
}

# Example 4: Network security level with more complex validation
variable "security_level" {
  description = "Security level for network access"
  type        = string
  default     = "medium"

  validation {
    condition = can(regex("^(low|medium|high|critical)$", var.security_level))
    error_message = "Security level must be exactly one of: low, medium, high, critical (case-sensitive)."
  }
}

# Example 5: Application deployment strategy
variable "deployment_strategy" {
  description = "Strategy for application deployment"
  type        = string
  default     = "rolling"

  validation {
    condition = contains([
      "blue-green",
      "rolling", 
      "canary",
      "recreate"
    ], var.deployment_strategy)
    error_message = "Deployment strategy must be one of: blue-green, rolling, canary, recreate."
  }
}

# Example 6: Storage replication type (Azure-like)
variable "storage_replication" {
  description = "Storage account replication type"
  type        = string
  default     = "LRS"

  validation {
    condition = contains(["LRS", "GRS", "RAGRS", "ZRS", "GZRS", "RAGZRS"], var.storage_replication)
    error_message = "Storage replication must be one of: LRS (Locally Redundant), GRS (Geo Redundant), RAGRS (Read-Access Geo Redundant), ZRS (Zone Redundant), GZRS (Geo Zone Redundant), RAGZRS (Read-Access Geo Zone Redundant)."
  }
}

# Example 7: Using locals to define enum values (best practice)
locals {
  allowed_regions = [
    "westeurope",
    "northeurope", 
    "eastus",
    "westus2",
    "southeastasia"
  ]
}

variable "azure_region" {
  description = "Azure region for resource deployment"
  type        = string
  default     = "westeurope"

  validation {
    condition = contains(local.allowed_regions, var.azure_region)
    error_message = "Azure region must be one of the allowed regions: ${join(", ", local.allowed_regions)}."
  }
}

# Example 8: Boolean-like enum for feature flags
variable "monitoring_level" {
  description = "Level of monitoring to enable"
  type        = string
  default     = "standard"

  validation {
    condition = contains(["none", "basic", "standard", "advanced"], var.monitoring_level)
    error_message = "Monitoring level must be one of: none, basic, standard, advanced."
  }
}
