# Terraform Associate Certification (003) - Complete Study Guide

## 📋 Exam Overview

- **Exam Code**: Terraform Associate (003)
- **Duration**: 1 hour
- **Questions**: 57 multiple-choice questions
- **Passing Score**: 70%
- **Cost**: $70.50 USD
- **Valid for**: 2 years
- **Format**: Online proctored or in-person at testing centers

---

## 🎯 Exam Objectives (Learning Areas)

### 1. **Understand Infrastructure as Code (IaC) concepts** (16.7%)
### 2. **Understand the purpose of Terraform** (16.7%)
### 3. **Understand Terraform basics** (16.7%)
### 4. **Use Terraform outside the core workflow** (8.3%)
### 5. **Interact with Terraform modules** (8.3%)
### 6. **Use the core Terraform workflow** (16.7%)
### 7. **Implement and maintain state** (8.3%)
### 8. **Read, generate, and modify configuration** (16.7%)
### 9. **Understand HCP Terraform capabilities** (8.3%)

---

## 📚 Detailed Study Content

## 1. Infrastructure as Code (IaC) Concepts

### 🔑 Key Concepts
- **Infrastructure as Code**: Managing infrastructure through machine-readable definition files
- **Benefits of IaC**:
  - Version control for infrastructure
  - Repeatable deployments
  - Consistency across environments
  - Documentation through code
  - Reduced manual errors
  - Cost optimization

### 📝 Quick Facts
```
Traditional IT: Manual, error-prone, inconsistent
IaC: Automated, reliable, version-controlled, repeatable
```

### ⚡ Cheat Sheet
```bash
# IaC Principles
✓ Declarative (what you want, not how)
✓ Idempotent (same result every time)
✓ Version controlled
✓ Self-documenting
✓ Testable
```

---

## 2. Purpose of Terraform

### 🔑 Key Concepts
- **Multi-cloud provisioning**: Deploy across AWS, Azure, GCP, etc.
- **Resource management**: Create, update, delete infrastructure
- **State management**: Track resource relationships and metadata
- **Plan and predict changes**: See what will happen before applying

### 📝 Terraform vs Other Tools
```
Terraform: Multi-cloud, declarative, state management
ARM Templates: Azure-only, declarative
Ansible: Configuration management, procedural
Pulumi: Multi-cloud, multiple programming languages
```

### ⚡ Cheat Sheet
```bash
# Terraform Advantages
✓ Cloud-agnostic
✓ Large provider ecosystem
✓ Immutable infrastructure
✓ Execution plans
✓ Resource graph
✓ Open source
```

---

## 3. Terraform Basics

### 🔑 Core Components

#### **Providers**
```hcl
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  required_version = ">= 1.0"
}

provider "azurerm" {
  features {}
}
```

#### **Resources**
```hcl
resource "azurerm_virtual_machine" "example" {
  name                = "terraform-vm"
  location            = "West Europe"
  resource_group_name = azurerm_resource_group.example.name
  vm_size             = "Standard_B1s"
  
  tags = {
    Name        = "terraform-example"
    Environment = "dev"
  }
}
```

#### **Data Sources**
```hcl
data "azurerm_image" "ubuntu" {
  name                = "ubuntu-20.04"
  resource_group_name = "packer-images"
}

data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "example" {
  name = "existing-resource-group"
}
```

### ⚡ File Structure Cheat Sheet
```
project/
├── main.tf           # Main configuration
├── variables.tf      # Input variables
├── outputs.tf        # Output values
├── terraform.tf      # Terraform settings
├── terraform.tfvars  # Variable values
└── .terraform/       # Terraform working directory
```

---

## 4. Core Terraform Workflow

### 🔄 The Four-Step Workflow

#### **1. Write**
```hcl
# Create configuration files
resource "azurerm_virtual_machine" "web" {
  name                = "web-vm"
  location            = "West Europe"
  resource_group_name = azurerm_resource_group.example.name
  vm_size             = "Standard_B1s"
}
```

#### **2. Plan**
```bash
terraform plan
# Shows what will be created/modified/destroyed
```

#### **3. Apply**
```bash
terraform apply
# Executes the planned changes
```

#### **4. Destroy** (when needed)
```bash
terraform destroy
# Removes all managed infrastructure
```

### ⚡ Command Cheat Sheet
```bash
# Essential Commands
terraform init          # Initialize working directory
terraform validate       # Validate configuration syntax
terraform fmt           # Format configuration files
terraform plan          # Create execution plan
terraform apply         # Apply changes
terraform destroy       # Destroy infrastructure
terraform show          # Show current state
terraform output        # Show output values
```

---

## 5. Advanced Commands & Workflow

### 🛠️ State Management Commands
```bash
# State inspection
terraform state list                    # List resources in state
terraform state show <resource>         # Show resource details
terraform state pull                    # Download remote state

# State manipulation
terraform state mv <old> <new>          # Rename resource
terraform state rm <resource>           # Remove from state
terraform import <resource> <id>        # Import existing resource
terraform refresh                       # Update state with real infrastructure
```

### 🔧 Advanced Workflow Commands
```bash
# Targeting specific resources
terraform plan -target=azurerm_virtual_machine.web
terraform apply -target=azurerm_virtual_machine.web

# Using variable files
terraform apply -var-file="prod.tfvars"

# Output formats
terraform output -json
terraform show -json

# Debugging
export TF_LOG=DEBUG
export TF_LOG_PATH="terraform.log"
```

### ⚡ Troubleshooting Cheat Sheet
```bash
# Common Issues & Solutions
terraform init -upgrade              # Upgrade providers
terraform apply -replace=<resource>  # Force resource recreation
terraform apply -refresh-only        # Sync state with reality
terraform force-unlock <lock-id>     # Unlock stuck state
```

---

## 6. Modules

### 🧩 Module Basics

#### **Using Modules**
```hcl
module "network" {
  source = "Azure/network/azurerm"
  version = "3.0.0"
  
  resource_group_name = "my-rg"
  address_space       = "10.0.0.0/16"
  subnet_prefixes     = ["10.0.1.0/24", "10.0.2.0/24"]
  subnet_names        = ["subnet1", "subnet2"]
  
  tags = {
    Environment = "dev"
  }
}
```

#### **Creating Modules**
```
modules/
└── webserver/
    ├── main.tf
    ├── variables.tf
    ├── outputs.tf
    └── README.md
```

#### **Module Sources**
```hcl
# Local module
module "local" {
  source = "./modules/webserver"
}

# Terraform Registry
module "registry" {
  source  = "Azure/network/azurerm"
  version = "~> 3.0"
}

# Git repository
module "git" {
  source = "git::https://github.com/user/repo.git//modules/network"
}
```

### ⚡ Module Cheat Sheet
```bash
# Module Commands
terraform get           # Download/update modules
terraform init          # Also downloads modules

# Module Best Practices
✓ Use semantic versioning
✓ Pin module versions
✓ Document inputs/outputs
✓ Follow naming conventions
✓ Use local modules for reusable code
```

---

## 7. Variables, Outputs & Data Types

### 📥 Input Variables
```hcl
variable "vm_size" {
  description = "Azure VM size"
  type        = string
  default     = "Standard_B1s"
  
  validation {
    condition     = contains(["Standard_B1s", "Standard_B2s"], var.vm_size)
    error_message = "VM size must be Standard_B1s or Standard_B2s."
  }
}

variable "locations" {
  description = "List of Azure regions"
  type        = list(string)
  default     = ["West Europe", "North Europe"]
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}
```

### 📤 Output Values
```hcl
output "vm_id" {
  description = "ID of the Azure VM"
  value       = azurerm_virtual_machine.web.id
}

output "vm_public_ip" {
  description = "Public IP address"
  value       = azurerm_public_ip.web.ip_address
  sensitive   = false
}
```

### 🗂️ Data Types
```hcl
# Primitive Types
string = "hello"
number = 42
bool   = true

# Complex Types
list(string)    = ["a", "b", "c"]
set(string)     = ["a", "b"]
map(string)     = {
  key1 = "value1"
  key2 = "value2"
}
tuple([string, number]) = ["hello", 42]
object({
  name = string
  age  = number
}) = {
  name = "John"
  age  = 30
}
```

### ⚡ Variable Precedence (Highest to Lowest)
```
1. Command line (-var, -var-file)
2. *.auto.tfvars files
3. terraform.tfvars file
4. Environment variables (TF_VAR_name)
5. Variable defaults
```

---

## 8. Configuration Language (HCL)

### 🎯 Resource References
```hcl
# Reference resource attributes
azurerm_virtual_machine.web.id
azurerm_public_ip.web.ip_address

# Reference data sources
data.azurerm_image.ubuntu.id

# Reference variables
var.vm_size

# Reference module outputs
module.network.vnet_id
```

### 🔧 Built-in Functions
```hcl
# String functions
upper("hello")                  # "HELLO"
lower("WORLD")                  # "world"
substr("hello", 1, 3)          # "ell"
replace("hello", "l", "x")     # "hexxo"

# Collection functions
length(["a", "b", "c"])        # 3
concat(["a"], ["b", "c"])      # ["a", "b", "c"]
contains(["a", "b"], "a")      # true
merge({a=1}, {b=2})           # {a=1, b=2}

# Type conversion
tostring(42)                   # "42"
tonumber("42")                 # 42
tolist(toset(["a", "b", "a"])) # ["a", "b"]

# Date/time functions
timestamp()                    # "2023-01-01T00:00:00Z"
formatdate("DD/MM/YYYY", timestamp())
```

### 🔄 Expressions
```hcl
# Conditional expressions
var.environment == "prod" ? "Standard_D2s_v3" : "Standard_B1s"

# For expressions
[for s in var.list : upper(s)]
{for k, v in var.map : k => upper(v)}

# Splat expressions
var.vms[*].id
var.vms[*].tags.Name
```

### ⚡ HCL Syntax Cheat Sheet
```hcl
# Comments
# Single line comment
/* Multi-line
   comment */

# Interpolation
"Hello ${var.name}"

# Heredoc
<<EOF
Multi-line
string content
EOF

# Dynamic blocks
dynamic "tag" {
  for_each = var.tags
  content {
    key   = tag.key
    value = tag.value
  }
}
```

---

## 9. State Management

### 🗃️ State Basics
```bash
# State is stored in terraform.tfstate
# Contains resource mappings and metadata
# Should be stored remotely for teams
```

### 🏗️ Remote Backends
```hcl
# Azure Storage Backend
terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "terraformstatesa"
    container_name       = "tfstate"
    key                  = "path/to/terraform.tfstate"
  }
}

# Terraform Cloud Backend
terraform {
  cloud {
    organization = "my-org"
    
    workspaces {
      name = "my-workspace"
    }
  }
}
```

### 🔒 State Management Best Practices
```bash
# State Security
✓ Enable encryption at rest
✓ Use state locking
✓ Restrict access (IAM policies)
✓ Enable versioning
✓ Regular backups

# State Operations
terraform state list                    # List all resources
terraform state show azurerm_virtual_machine.web   # Show specific resource
terraform state mv old_name new_name    # Rename resource
terraform state rm azurerm_virtual_machine.web     # Remove from state
terraform import azurerm_virtual_machine.web /subscriptions/.../resourceGroups/.../providers/Microsoft.Compute/virtualMachines/myvm # Import existing resource
```

### ⚡ State Troubleshooting
```bash
# Common State Issues
terraform refresh              # Sync state with reality
terraform apply -refresh-only  # Refresh without changes
terraform force-unlock ID      # Unlock state manually
terraform state pull > backup  # Create state backup
```

---

## 10. HCP Terraform (Terraform Cloud)

### ☁️ Key Features
- **Remote state management**: Secure, encrypted state storage
- **Remote operations**: Plan and apply in the cloud
- **VCS integration**: GitHub, GitLab, Bitbucket integration
- **Team collaboration**: User management and permissions
- **Policy enforcement**: Sentinel policies for governance
- **Private registry**: Store and share private modules

### 🏢 Workspaces
```hcl
# Workspace types
# 1. VCS-driven: Connected to Git repository
# 2. API-driven: Managed via API/CLI
# 3. CLI-driven: Local operations, remote state
```

### 👥 Team Management
```bash
# Permission levels
Read     # View workspace and state
Plan     # Create plans
Write    # Apply changes
Admin    # Manage workspace settings
Manage   # Full control including deletion
```

### 🛡️ Sentinel Policies
```hcl
# Example policy: Require tags
import "tfplan/v2" as tfplan

required_tags = ["Environment", "Owner"]

main = rule {
  all tfplan.resource_changes as _, rc {
    rc.mode is "managed" and
    rc.change.actions contains "create" and
    rc.type matches "azurerm_.*"
    implies
    all required_tags as tag {
      rc.change.after.tags contains tag
    }
  }
}
```

### ⚡ HCP Terraform Cheat Sheet
```bash
# CLI Integration
terraform login                 # Authenticate with TF Cloud
terraform logout               # Remove credentials

# Workspace Management
terraform workspace list       # List workspaces
terraform workspace new dev    # Create workspace
terraform workspace select dev # Switch workspace

# Remote Operations
terraform plan   # Plan in Terraform Cloud
terraform apply  # Apply in Terraform Cloud
```

---

## 📝 Quick Reference Cards

### Essential Commands Card
```bash
terraform init      # Initialize directory
terraform validate  # Validate syntax
terraform fmt       # Format code
terraform plan      # Preview changes
terraform apply     # Apply changes
terraform destroy   # Destroy infrastructure
terraform show      # Show state
terraform output    # Show outputs
```

### Variable Precedence Card
```
1. -var and -var-file (command line)
2. *.auto.tfvars and *.auto.tfvars.json
3. terraform.tfvars and terraform.tfvars.json
4. Environment variables (TF_VAR_*)
5. Default values in variable declarations
```

### State Commands Card
```bash
terraform state list          # List resources
terraform state show <addr>   # Show resource
terraform state mv <old> <new> # Move resource
terraform state rm <addr>     # Remove resource
terraform import <addr> <id>  # Import resource
terraform refresh             # Refresh state
```

### Module Structure Card
```
module/
├── main.tf        # Main configuration
├── variables.tf   # Input variables
├── outputs.tf     # Output values
├── versions.tf    # Version constraints
└── README.md      # Documentation
```

### Azure Resource Examples Card
```hcl
# Resource Group
resource "azurerm_resource_group" "example" {
  name     = "rg-example"
  location = "West Europe"
}

# Virtual Network
resource "azurerm_virtual_network" "example" {
  name                = "vnet-example"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

# Storage Account
resource "azurerm_storage_account" "example" {
  name                     = "storageexample"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
```

### Azure Data Sources Card
```hcl
# Current subscription
data "azurerm_subscription" "current" {}

# Current client configuration
data "azurerm_client_config" "current" {}

# Existing resource group
data "azurerm_resource_group" "example" {
  name = "existing-rg"
}

# Available VM sizes
data "azurerm_virtual_machine_sizes" "example" {
  location = "West Europe"
}
```

---

## 🎯 Exam Tips & Strategies

### 📚 Study Approach
1. **Hands-on practice**: Set up real infrastructure
2. **Read documentation**: Official Terraform docs
3. **Practice scenarios**: Common use cases
4. **Time management**: ~1 minute per question
5. **Review basics**: Don't skip fundamentals

### ⚠️ Common Pitfalls to Avoid
- Confusing `terraform apply` vs `terraform plan`
- Not understanding state file importance
- Mixing up variable precedence order
- Forgetting about provider version constraints
- Not knowing the difference between resources and data sources

### 🔥 High-Yield Topics
1. **State management** (very important)
2. **Module usage and creation**
3. **Variable types and precedence**
4. **Core workflow commands**
5. **Provider configuration**
6. **Resource dependencies**
7. **Terraform Cloud features**

### 📖 Must-Know Concepts
- What happens during `terraform init`
- Difference between `plan` and `apply`
- How state locking works
- Module versioning best practices
- Variable validation rules
- Output value usage
- Backend configuration
- Resource addressing syntax

---

## 🔗 Additional Resources

### Azure-Specific Resources
- [AzureRM Provider Documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Azure Terraform Examples](https://github.com/hashicorp/terraform-provider-azurerm/tree/main/examples)
- [Azure Architecture Center - Terraform](https://docs.microsoft.com/en-us/azure/architecture/guide/technology-choices/terraform)
- [Azure Quick Start Templates](https://github.com/Azure/azure-quickstart-templates)

### Official Documentation
- [Terraform Documentation](https://developer.hashicorp.com/terraform)
- [Terraform Registry](https://registry.terraform.io/)
- [HCP Terraform Documentation](https://developer.hashicorp.com/terraform/cloud-docs)

### Practice Resources
- [HashiCorp Learn](https://learn.hashicorp.com/terraform)
- [Terraform Examples](https://github.com/hashicorp/terraform-guides)
- [Sample Questions](https://developer.hashicorp.com/terraform/tutorials/certification-003/associate-questions)

### Community Resources
- [Terraform GitHub](https://github.com/hashicorp/terraform)
- [Terraform Community Forum](https://discuss.hashicorp.com/c/terraform-core)
- [r/Terraform Subreddit](https://www.reddit.com/r/Terraform/)

---

## ✅ Pre-Exam Checklist

### Knowledge Areas to Verify
- [ ] Can explain Infrastructure as Code benefits
- [ ] Understand Terraform's purpose and advantages
- [ ] Know the core workflow (init, plan, apply, destroy)
- [ ] Can create and use modules
- [ ] Understand state management and backends
- [ ] Know variable types and precedence
- [ ] Familiar with HCP Terraform features
- [ ] Can read and write HCL configuration
- [ ] Understand resource dependencies
- [ ] Know troubleshooting commands

### Practical Skills to Test
- [ ] Initialize a new Terraform project
- [ ] Create resources with dependencies
- [ ] Use modules from the registry
- [ ] Manage state manually
- [ ] Configure remote backends
- [ ] Use variables and outputs
- [ ] Import existing resources
- [ ] Debug configuration issues

---

## 🚀 Final Exam Strategy

### Before the Exam
1. Get a good night's sleep
2. Review this cheat sheet
3. Practice key commands
4. Set up your testing environment
5. Check technical requirements

### During the Exam
1. Read questions carefully
2. Eliminate obviously wrong answers
3. Use process of elimination
4. Don't spend too long on any question
5. Review flagged questions at the end

### Question Types to Expect
- Multiple choice (single answer)
- Multiple select (multiple answers)
- Scenario-based questions
- Command syntax questions
- Best practices questions

---

*Good luck with your Terraform Associate Certification exam! 🎉*

**Remember**: Practice makes perfect. Set up real infrastructure, break things, fix them, and learn from the experience. The hands-on knowledge is invaluable both for the exam and your career!
