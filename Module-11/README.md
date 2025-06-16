# Module 11: VNet and Subnets Design Patterns

This module demonstrates different approaches for managing Azure Virtual Networks and Subnets with Terraform.

## Problem Statement
How to best structure Terraform modules when you have a VNet and want to add multiple subnets using `for_each`?

## Approaches Demonstrated

### 1. Single Module Approach (`single-module/`)
- VNet and subnets managed in one module
- Uses `for_each` to create multiple subnets
- Simpler structure but less flexible

### 2. Two Module Approach (`two-modules/`)
- Separate VNet module and subnet module
- More modular and reusable
- Better separation of concerns

### 3. Usage Examples (`usage-examples/`)
- Real-world examples of how to use both approaches
- Different scenarios and use cases

## Key Considerations

### Single Module Pros:
- Simpler to understand and maintain
- All networking resources in one place
- Good for simple, predictable scenarios

### Single Module Cons:
- Less flexible for complex scenarios
- Harder to reuse subnet logic independently
- Difficult to add subnets to existing VNets from other sources

### Two Module Pros:
- Better separation of concerns
- More reusable and flexible
- Can add subnets to existing VNets
- Easier to test individual components

### Two Module Cons:
- More complex structure
- Need to manage dependencies between modules
- Slightly more overhead

## Recommendation
Use **two modules** for production environments and **single module** for simple development scenarios.
