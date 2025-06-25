# Simple Enum Example
# This file shows the most basic enum-like behavior

terraform {
  required_version = ">= 1.5.0"
  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "ffbf501f-f220-4b59-8d0a-5068d961cc5f"
}

# STEP 1: Define a variable that only accepts specific values
variable "environment" {
  description = "The environment to deploy to"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod"
  }
}

# STEP 2: Use the variable in a resource
resource "azurerm_resource_group" "simple_example" {
  name     = "rg-simple-${var.environment}"
  location = "West Europe"

  tags = {
    Environment = var.environment
  }
}

# STEP 3: Test it!
# Run these commands to see how it works:
#
# ✅ This will work:
# terraform plan -var="environment=dev"
# terraform plan -var="environment=staging" 
# terraform plan -var="environment=prod"
#
# ❌ This will fail with validation error:
# terraform plan -var="environment=test"
# terraform plan -var="environment=development"
