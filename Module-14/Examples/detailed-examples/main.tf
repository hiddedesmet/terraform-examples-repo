# Provider configuration is now in versions.tf

# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = "rg-enum-example-${var.environment}"
  location = var.azure_region

  tags = {
    Environment       = var.environment
    SecurityLevel     = var.security_level
    MonitoringLevel   = var.monitoring_level
    DeploymentStrategy = var.deployment_strategy
  }
}

# Create a storage account using the enum-like variables
resource "azurerm_storage_account" "example" {
  name                     = "stenumexample${var.environment}${random_integer.suffix.result}"
  resource_group_name      = azurerm_resource_group.example.name
  location                = azurerm_resource_group.example.location
  account_tier             = var.database_tier == "premium" ? "Premium" : "Standard"
  account_replication_type = var.storage_replication

  # Use the security level to determine network rules
  network_rules {
    default_action = var.security_level == "high" || var.security_level == "critical" ? "Deny" : "Allow"
    bypass         = var.security_level == "critical" ? ["None"] : ["AzureServices"]
  }

  tags = {
    Environment     = var.environment
    SecurityLevel   = var.security_level
    MonitoringLevel = var.monitoring_level
    Tier           = var.database_tier
  }
}

# Random integer for unique naming
resource "random_integer" "suffix" {
  min = 1000
  max = 9999
}

# Conditional resource creation based on enum values
resource "azurerm_monitor_action_group" "example" {
  count               = var.monitoring_level != "none" ? 1 : 0
  name                = "ag-enum-example-${var.environment}"
  resource_group_name = azurerm_resource_group.example.name
  short_name          = "enumag"

  tags = {
    Environment     = var.environment
    MonitoringLevel = var.monitoring_level
  }
}

# Application Insights (only for standard and advanced monitoring)
resource "azurerm_application_insights" "example" {
  count               = contains(["standard", "advanced"], var.monitoring_level) ? 1 : 0
  name                = "ai-enum-example-${var.environment}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  application_type    = "web"

  tags = {
    Environment     = var.environment
    MonitoringLevel = var.monitoring_level
  }
}

# Example of using the deployment strategy in configuration
locals {
  # Configure deployment settings based on strategy
  deployment_config = {
    blue-green = {
      min_capacity = 2
      max_capacity = 10
      health_check_path = "/health"
    }
    rolling = {
      min_capacity = 1
      max_capacity = 5
      health_check_path = "/health"
    }
    canary = {
      min_capacity = 1
      max_capacity = 8
      health_check_path = "/ready"
    }
    recreate = {
      min_capacity = 0
      max_capacity = 3
      health_check_path = "/ping"
    }
  }

  current_deployment_config = local.deployment_config[var.deployment_strategy]
}

# Output the selected configuration
output "deployment_configuration" {
  description = "Current deployment configuration based on strategy"
  value = {
    strategy          = var.deployment_strategy
    min_capacity      = local.current_deployment_config.min_capacity
    max_capacity      = local.current_deployment_config.max_capacity
    health_check_path = local.current_deployment_config.health_check_path
  }
}
