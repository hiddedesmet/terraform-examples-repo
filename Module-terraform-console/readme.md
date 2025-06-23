# Using Terraform Console

To explore and test variables and local values defined in your Terraform configuration, you can use the `terraform console` command. Below are examples of how to use the console to interact with the variables and locals defined in this module:

## Initialize Terraform
Before using the console, ensure you have initialized Terraform in your working directory:

```bash
terraform init
```

## Start the Console
Run the following command to start the Terraform console:

```bash
terraform console
```

## Examples

### Accessing Variables
You can access the values of variables directly:

```hcl
var.app_name
# Output: "frontend"

var.env
# Output: "dev"
```

### Accessing Local Values
You can access the computed local values:

```hcl
local.full_name
# Output: "dev-frontend"

local.storage_class
# Output: "Standard_LRS"

local.labels
# Output: ["tier=standard", "enabled=true"]
```

### Using Lookup Function
You can use the `lookup` function to retrieve values from maps with a default fallback:

```hcl
lookup(var.settings, "tier", "default")
# Output: "standard"

lookup(var.settings, "missing", "default")
# Output: "default"
```

### Conditional Expressions
You can evaluate conditional expressions:

```hcl
var.env == "prod" ? "yes" : "no"
# Output: "no"
```

## Exit the Console
To exit the console, type:

```bash
exit
```