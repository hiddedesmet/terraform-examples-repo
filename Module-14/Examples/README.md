# Terraform Enum-like Variable Examples

## Super Simple Example

Here's the easiest way to understand enum-like behavior in Terraform:

### Step 1: Create a Variable with Limited Choices

```hcl
variable "app_environment" {
  description = "Which environment to deploy to"
  type        = string
  default     = "dev"

  validation {
    condition = contains(["dev", "staging", "prod"], var.app_environment)
    error_message = "Environment must be: dev, staging, or prod"
  }
}
```

### Step 2: Use It

```hcl
resource "azurerm_resource_group" "example" {
  name     = "my-app-${var.app_environment}"
  location = "West Europe"
}
```

### Step 3: Test It

```bash
# ✅ This works
terraform plan -var="app_environment=dev"

# ❌ This fails with error
terraform plan -var="app_environment=testing"
```

**Error you'll see:**
```
Error: Invalid value for variable
Environment must be: dev, staging, or prod
```

That's it! Now you have enum-like behavior - Terraform will only accept `dev`, `staging`, or `prod`.

---

## What are Enum-like Variables?

Enum-like variables in Terraform are string variables with validation rules that restrict the input to a predefined set of acceptable values. This provides:

- **Type safety**: Prevents invalid configuration values
- **Better documentation**: Clear indication of valid options
- **Early error detection**: Validation happens during `terraform plan`

## Implementation Techniques

### 1. Basic Validation with `contains()`

```hcl
variable "environment" {
  description = "The deployment environment"
  type        = string
  default     = "dev"

  validation {
    condition = contains(["dev", "test", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, test, staging, prod."
  }
}
```

### 2. Using Locals for Reusable Enum Values

```hcl
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
```

### 3. Regex-based Validation

```hcl
variable "security_level" {
  description = "Security level for network access"
  type        = string
  default     = "medium"

  validation {
    condition = can(regex("^(low|medium|high|critical)$", var.security_level))
    error_message = "Security level must be exactly one of: low, medium, high, critical (case-sensitive)."
  }
}
```

## Usage Examples

### Setting Variables

Create a `terraform.tfvars` file:

```hcl
environment = "prod"
vm_size = "Standard_D4s_v3"
security_level = "high"
monitoring_level = "advanced"
```

### Conditional Logic Based on Enum Values

```hcl
resource "azurerm_storage_account" "example" {
  # ... other configuration ...
  
  network_rules {
    default_action = var.security_level == "high" || var.security_level == "critical" ? "Deny" : "Allow"
    bypass         = var.security_level == "critical" ? ["None"] : ["AzureServices"]
  }
}
```

### Using Enum Values in Locals

```hcl
locals {
  deployment_config = {
    blue-green = {
      min_capacity = 2
      max_capacity = 10
    }
    rolling = {
      min_capacity = 1
      max_capacity = 5
    }
  }

  current_config = local.deployment_config[var.deployment_strategy]
}
```

## Running the Example

**Prerequisites:**
- Terraform >= 1.5.0
- Azure CLI installed and authenticated
- AzureRM Provider 4.x (latest: 4.34.0)

1. **Initialize Terraform:**
   ```bash
   terraform init
   ```

2. **Copy the example variables:**
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

3. **Edit the variables as needed:**
   ```bash
   # Edit terraform.tfvars with your preferred values
   ```

4. **Plan the deployment:**
   ```bash
   terraform plan
   ```

5. **Test validation by using invalid values:**
   ```bash
   # This will fail with a validation error
   terraform plan -var="environment=invalid"
   ```

## Validation Error Examples

When you provide invalid values, Terraform will show helpful error messages:

```
Error: Invalid value for variable

  on variables.tf line 1:
   1: variable "environment" {

Environment must be one of: dev, test, staging, prod.

This was checked by the validation rule at variables.tf:6,3-13.
```

## Best Practices

1. **Use descriptive error messages** that list all valid options
2. **Set sensible defaults** for your enum variables
3. **Group related enums** using locals for maintainability
4. **Document the purpose** of each enum value in comments
5. **Use consistent naming** conventions for enum values
6. **Consider case sensitivity** in your validation rules

## IDE Support

Most modern IDEs with Terraform support will provide auto-completion for variables with validation rules, making it easier to use the correct enum values.

## Important Note About Auto-completion

⚠️ **Key Limitation**: Terraform variable validation does NOT provide auto-completion when typing variable values in `.tfvars` files or when using `-var` flags. The validation only occurs during `terraform plan/apply`.

### What You DO Get Auto-completion For:
- Built-in Azure resource parameters (like `container_access_type` in your image)
- Variable names when referencing them (e.g., `var.environment`)
- Resource types and their parameters

### What You DON'T Get Auto-completion For:
- Custom variable values in `terraform.tfvars`
- Values passed via `-var` command line flags

### Better Alternatives for Auto-completion:

#### Option 1: Use Locals with Descriptive Comments
```hcl
locals {
  # Available environments: dev, test, staging, prod
  environment = "dev"  # Change this to: dev | test | staging | prod
  
  # Available VM sizes: Standard_B1s, Standard_B2s, Standard_B4ms, Standard_D2s_v3, etc.
  vm_size = "Standard_B2s"
}

# Then reference in variables
variable "environment" {
  description = "The deployment environment"
  type        = string
  default     = local.environment
  
  validation {
    condition = contains(["dev", "test", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, test, staging, prod."
  }
}
```

#### Option 2: Use Data Sources for Dynamic Enums
```hcl
# Get available VM sizes dynamically
data "azurerm_virtual_machine_sizes" "available" {
  location = "West Europe"
}

variable "vm_size" {
  description = "VM size (check data.azurerm_virtual_machine_sizes.available for options)"
  type        = string
  validation {
    condition = contains(data.azurerm_virtual_machine_sizes.available.sizes[*].name, var.vm_size)
    error_message = "VM size must be available in the selected region."
  }
}
```

#### Option 3: Document Valid Values Clearly
```hcl
variable "environment" {
  description = <<-EOF
    The deployment environment.
    Valid values: dev, test, staging, prod
    Default: dev
  EOF
  type        = string
  default     = "dev"
  
  validation {
    condition = contains(["dev", "test", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, test, staging, prod."
  }
}
```

## Files in this Example

### Main Directory (Simple Example)
- `simple-enum-example.tf` - Basic enum validation example with just one variable
- `simple.tfvars` - Example values for the simple example
- `terraform.tfvars.example` - Template for variable values
- `README.md` - This documentation

### Detailed Examples Directory
- `detailed-examples/` - Contains comprehensive examples with multiple enum variables:
  - `variables.tf` - 8 different enum variable examples
  - `main.tf` - Complex usage examples with conditional logic
  - `outputs.tf` - Demonstrations of how enum values affect outputs
  - `versions.tf` - Provider configuration
  - `terraform.tfvars.example` - Example variable values

## Quick Start

### Simple Example (Main Directory)
```bash
# Test the basic enum example
terraform init
terraform plan -var="environment=dev"     # ✅ Works
terraform plan -var="environment=invalid" # ❌ Fails
```

### Detailed Examples
```bash
# Test the comprehensive examples
cd detailed-examples/
terraform init
terraform plan
terraform plan -var="security_level=high" -var="monitoring_level=advanced"
```

## Related Azure Resources with Built-in Enums

Many Azure resources already implement enum-like behavior:

- `azurerm_storage_container.container_access_type`: `"blob"`, `"container"`, `"private"`
- `azurerm_storage_account.account_tier`: `"Standard"`, `"Premium"`
- `azurerm_storage_account.account_replication_type`: `"LRS"`, `"GRS"`, `"RAGRS"`, etc.
- `azurerm_virtual_machine.vm_size`: Various SKU options
- `azurerm_app_service_plan.sku.tier`: `"Free"`, `"Shared"`, `"Basic"`, `"Standard"`, `"Premium"`
