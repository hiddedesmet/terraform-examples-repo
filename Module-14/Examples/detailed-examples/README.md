# Detailed Terraform Enum Examples

This directory contains comprehensive examples demonstrating advanced enum-like behavior in Terraform with multiple variables and conditional logic.

## What's Different from the Simple Example

- **8 different enum variables** instead of just one
- **Conditional resource creation** based on enum values
- **Dynamic configuration** using enum values in locals
- **Complex validation patterns** (regex, locals-based)
- **Real-world scenarios** (VM sizes, security levels, deployment strategies)

## Running the Examples

```bash
# Initialize Terraform
terraform init

# Test with default values
terraform plan

# Test with different enum combinations
terraform plan -var="security_level=high" -var="monitoring_level=advanced"
terraform plan -var="deployment_strategy=blue-green" -var="database_tier=premium"

# Test validation errors
terraform plan -var="vm_size=invalid_size"     # Should fail
terraform plan -var="environment=testing"     # Should fail
```

## Key Features Demonstrated

1. **Multiple enum variables** working together
2. **Conditional resource creation** (`monitoring_level=none` creates no monitoring resources)
3. **Dynamic storage configuration** (security level affects network rules)
4. **Complex locals** using enum values to configure deployment settings
5. **Comprehensive outputs** showing how enums affect infrastructure

## Files

- `variables.tf` - 8 enum variable definitions
- `main.tf` - Complex infrastructure using enum values
- `outputs.tf` - Detailed outputs showing enum effects
- `versions.tf` - Latest provider configurations
- `terraform.tfvars.example` - Example values for all variables
