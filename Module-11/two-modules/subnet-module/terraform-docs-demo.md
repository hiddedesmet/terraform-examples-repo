# Terraform Documentation Generation Demo

This guide demonstrates how to use `terraform-docs` with a configuration file to automatically generate documentation for Terraform modules.

## Overview

`terraform-docs` is a utility that generates documentation from Terraform modules in various output formats. It can automatically extract information about:
- Input variables
- Output values
- Resources
- Providers
- Requirements

## Prerequisites

1. Install terraform-docs using Homebrew (macOS):
   ```bash
   brew install terraform-docs
   ```

2. Verify installation:
   ```bash
   terraform-docs version
   ```

## Configuration File Setup

Create a `.terraform.docs.yml` file in your module directory with the following configuration:

```yaml
formatter: "markdown" # this is required

version: ""

header-from: main.tf
footer-from: ""

recursive:
  enabled: false
  path: modules
  include-main: true

sections:
  hide: []
  show: []

content: ""

output:
  file: "README.md"
  mode: inject
  template: |-
    <!-- BEGIN_TF_DOCS -->
    {{ .Content }}
    <!-- END_TF_DOCS -->

output-values:
  enabled: false
  from: ""

sort:
  enabled: true
  by: name

settings:
  anchor: true
  color: true
  default: true
  description: false
  escape: true
  hide-empty: false
  html: true
  indent: 2
  lockfile: true
  read-comments: true
  required: true
  sensitive: true
  type: true
```

### Key Configuration Options

- **`formatter`**: Specifies output format (markdown, json, yaml, etc.)
- **`output.file`**: Target file for documentation injection
- **`output.mode`**: How to handle output (`inject` or `replace`)
- **`header-from`**: File to extract header documentation from
- **`sort.enabled`**: Whether to sort items alphabetically
- **`settings`**: Various formatting and display options

## Prepare Your README.md

Ensure your README.md file contains the injection markers:

```markdown
# Your Module Title

Your module description here.

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->
```

## Generate Documentation

### Method 1: Using Configuration File (Recommended)

Run terraform-docs with explicit configuration reference:

```bash
terraform-docs -c .terraform.docs.yml .
```

### Method 2: Automatic Configuration Detection

If the config file is named `.terraform.docs.yml`, terraform-docs should auto-detect it:

```bash
terraform-docs .
```

**Note**: In some versions, you may need to use Method 1 for reliable results.

## Expected Output

The command will:
1. Read your Terraform files (`main.tf`, `variables.tf`, `outputs.tf`)
2. Extract documentation from comments and variable definitions
3. Generate formatted markdown tables
4. Inject the documentation between the markers in README.md

### Generated Sections

- **Requirements**: Terraform version constraints
- **Providers**: Required providers and versions
- **Modules**: Child modules (if any)
- **Resources**: All resources created by the module
- **Inputs**: All input variables with types, descriptions, defaults
- **Outputs**: All output values with descriptions

## Example Generated Documentation

```markdown
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| azurerm | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_subnet.subnets](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| resource_group_name | Name of the resource group | `string` | n/a | yes |
| subnets | Map of subnets to create | `map(object({...}))` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| subnet_ids | Map of subnet names to their IDs |
```

## Automation Tips

### 1. Git Hook Integration

Add to `.git/hooks/pre-commit`:
```bash
#!/bin/sh
terraform-docs -c .terraform.docs.yml .
git add README.md
```

### 2. CI/CD Pipeline

Add to your pipeline:
```yaml
- name: Update Terraform docs
  run: |
    terraform-docs -c .terraform.docs.yml .
    git diff --exit-code README.md || echo "Documentation needs updating"
```

### 3. Make Target

Add to `Makefile`:
```makefile
docs:
	terraform-docs -c .terraform.docs.yml .

.PHONY: docs
```

## Troubleshooting

### Common Issues

1. **Empty formatter field**: Ensure `formatter: "markdown"` is set
2. **No output file**: Set `output.file: "README.md"`
3. **Missing markers**: Add `<!-- BEGIN_TF_DOCS -->` and `<!-- END_TF_DOCS -->` to README.md
4. **Configuration not detected**: Use explicit `-c .terraform.docs.yml` flag

### Validation

After running terraform-docs, verify:
- README.md was updated with timestamp
- Documentation appears between markers
- All variables and outputs are included
- Links to Terraform registry work

## Best Practices

1. **Descriptive variable descriptions**: Always add meaningful descriptions to variables
2. **Consistent naming**: Use clear, consistent naming for variables and outputs
3. **Version your config**: Include `.terraform.docs.yml` in version control
4. **Regular updates**: Run terraform-docs after any module changes
5. **Review generated docs**: Ensure generated documentation is accurate and helpful

## Advanced Configuration

### Custom Sections

Hide unnecessary sections:
```yaml
sections:
  hide: [header, footer]
  show: [requirements, providers, inputs, outputs]
```

### Custom Template

Use custom output template:
```yaml
output:
  template: |-
    ## 📋 Module Documentation
    {{ .Content }}
```

### Multiple Output Formats

Generate multiple formats:
```bash
terraform-docs markdown . > docs/README.md
terraform-docs json . > docs/module.json
```

---

## Demo Script

For live demonstration:

1. Show existing module files (`main.tf`, `variables.tf`, `outputs.tf`)
2. Display `.terraform.docs.yml` configuration
3. Show README.md with empty markers
4. Run `terraform-docs -c .terraform.docs.yml .`
5. Display updated README.md with generated documentation
6. Explain each section of the generated output
7. Show how changes to variables automatically update documentation

This process demonstrates infrastructure-as-code documentation best practices and automation capabilities.
