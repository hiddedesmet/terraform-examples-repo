# Outputs demonstrating enum-like variable usage

output "environment_info" {
  description = "Information about the selected environment"
  value = {
    environment         = var.environment
    azure_region       = var.azure_region
    security_level     = var.security_level
    monitoring_enabled = var.monitoring_level != "none"
  }
}

output "infrastructure_config" {
  description = "Infrastructure configuration based on enum selections"
  value = {
    vm_size             = var.vm_size
    database_tier       = var.database_tier
    storage_replication = var.storage_replication
    deployment_strategy = var.deployment_strategy
  }
}

output "resource_names" {
  description = "Generated resource names using enum values"
  value = {
    resource_group_name = azurerm_resource_group.example.name
    storage_account_name = azurerm_storage_account.example.name
  }
}

output "conditional_resources" {
  description = "Resources created based on enum conditions"
  value = {
    monitoring_action_group_created = length(azurerm_monitor_action_group.example) > 0
    application_insights_created    = length(azurerm_application_insights.example) > 0
    storage_network_restricted      = azurerm_storage_account.example.network_rules[0].default_action == "Deny"
  }
}

output "validation_examples" {
  description = "Examples of how enum validation works"
  value = {
    valid_environments       = ["dev", "test", "staging", "prod"]
    valid_vm_sizes          = ["Standard_B1s", "Standard_B2s", "Standard_B4ms", "Standard_D2s_v3", "Standard_D4s_v3", "Standard_F2s_v2", "Standard_F4s_v2"]
    valid_security_levels   = ["low", "medium", "high", "critical"]
    valid_monitoring_levels = ["none", "basic", "standard", "advanced"]
  }
}
