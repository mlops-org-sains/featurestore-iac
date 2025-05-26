# Required Tags Implementation

This document explains how required tags are consistently applied to all Azure resources in the infrastructure.

## Overview

We've implemented a centralized tagging system using the existing `local.tags` pattern in each environment. This ensures that all required tags are consistently applied to every resource created by Terraform.

## Required Tags

The following tags are applied to all resources:

| Tag Name | Description |
|----------|-------------|
| Environment | The deployment environment (dev, test, prod, shared) |
| Project | Project name ("MLOps Accelerator") |
| Terraform | Indicates resource is managed by Terraform (always "true") |
| email | Contact email for the resources |
| costcentre | Cost center for billing |
| live | Indicates if the resource is live |
| servicename | Name of the service |
| servicecatalogueID | Service catalogue ID |
| dataRetention | Data retention period |
| dataClassification | Classification of data stored |

## Implementation

The implementation follows these key principles:

1. **Centralized Definition**:
   - Tags are defined once in each environment's `main.tf` file in the `locals` block
   - All resources and modules reference this single definition

2. **Consistent Values**:
   - Tag values are provided via variables in each environment's `terraform.tfvars` file
   - The `setup.sh` script ensures consistent default values

3. **Resource Application**:
   - Each resource and module already includes a `tags = local.tags` parameter
   - No changes needed to individual resource definitions

4. **Terraform State Resources**:
   - The `setup.sh` script applies the same required tags to the Terraform state resource group and storage account
   - These resources are created directly with Azure CLI commands

## Adding New Tags

To add a new required tag:

1. Add the tag to the `local.tags` block in each environment's `main.tf`
2. Add the corresponding variable in each environment's `variables.tf`
3. Update the `setup.sh` script to:
   - Include the new tag in the `terraform.tfvars` generation
   - Add the new tag to the `TAGS` variable for Terraform state resources
