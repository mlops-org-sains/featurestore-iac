# Terraform Setup and Deployment Guide

This guide explains how to set up and deploy the Azure MLOps infrastructure using Terraform.

## Prerequisites

Before starting, ensure you have:

1. **Azure CLI** installed and configured
   ```bash
   # Install Azure CLI (follow OS-specific instructions)
   # https://docs.microsoft.com/en-us/cli/azure/install-azure-cli

   # Login to Azure
   az login
   ```

2. **Terraform CLI** installed (version >= 1.0.0)
   ```bash
   # Install Terraform (follow OS-specific instructions)
   # https://learn.hashicorp.com/tutorials/terraform/install-cli

   # Verify installation
   terraform -v
   ```

3. **Access to an Azure subscription** with permissions to create resources

## Terraform State Setup

The MLOps accelerator uses Azure Storage for Terraform state management, allowing multiple team members to collaborate and providing state locking.

### Automated Setup

We provide a setup script that automates the state configuration:

1. Make the script executable:
   ```bash
   chmod +x terraform/environments/setup.sh
   ```

2. Run the setup script:
   ```bash
   ./terraform/environments/setup.sh
   ```

This script:
- Creates a resource group for Terraform state
- Creates a unique Azure Storage account
- Sets up a container for state files
- Configures backend files for each environment
- Creates terraform.tfvars files with the current subscription ID and tenant ID
- Initializes Terraform for each environment

### Manual Setup

If you prefer to set up the state storage manually:

1. Create a resource group:
   ```bash
   az group create --name terraform --location eastus
   ```

2. Create a storage account (name must be globally unique):
   ```bash
   az storage account create --name terraform<uniqueid> --resource-group terraform --sku Standard_LRS
   ```

3. Create a container:
   ```bash
   az storage container create --name tfstate --account-name terraform<uniqueid>
   ```

4. Create terraform.tfvars files in each environment directory containing:
   ```hcl
   subscription_id = "your-subscription-id"
   tenant_id       = "your-tenant-id"
   environment     = "shared|dev|test|prod"
   ```

5. Update backend.tf files in each environment directory:
   ```hcl
   terraform {
     backend "azurerm" {
       resource_group_name  = "terraform"
       storage_account_name = "terraform<uniqueid>"
       container_name       = "tfstate"
       key                  = "env/<environment>.tfstate"
       use_azuread_auth     = true
     }
   }
   ```

## Infrastructure Deployment

### Deployment Order

Deploy the environments in the following sequence:

1. **Shared Resources (Model Registry)**:
   ```bash
   cd terraform/environments/shared
   terraform init
   terraform plan
   terraform apply
   ```

2. **Development Environment**:
   ```bash
   cd ../dev
   terraform init
   terraform plan
   terraform apply
   ```

3. **Test Environment**:
   ```bash
   cd ../test
   terraform init
   terraform plan
   terraform apply
   ```

4. **Production Environment**:
   ```bash
   cd ../prod
   terraform init
   terraform plan
   terraform apply
   ```

### Verification

After deployment, verify the resources in the Azure Portal:

1. Navigate to the resource groups:
   - `mlops-shared-rg`
   - `mlops-dev-rg`
   - `mlops-test-rg`
   - `mlops-prod-rg`

2. Check that each environment has:
   - Azure Machine Learning workspace
   - Storage account
   - Virtual Network/Subnet
   - Compute clusters (may be stopped)
   - Registry connection to the shared model registry

3. Verify that the model registry in the shared resource group is accessible from each workspace:
   - In the Azure ML Studio UI, navigate to each workspace
   - Go to "Registries" in the left navigation
   - You should see the shared registry listed under "Azure ML registries"

## Customization

### Environment-Specific Settings

Each environment can be customized by modifying:

1. **terraform.tfvars**: Change the subscription, location, or environment name
2. **main.tf**: Update resource specifications (e.g., VM sizes, networking)

### Registry Connection

The MLOps accelerator creates connections between each environment's Azure ML workspace and the shared model registry. This enables:

1. Central model storage and versioning
2. Model promotion between environments (dev → test → prod)
3. Consistent model usage across all environments

The connection is implemented through:
- Azure ML workspace connections
- RBAC permissions for workspace identities
- Role assignments (Registry Contributor and Registry User)

### Common Customizations

#### Changing VM sizes for compute

```hcl
module "compute" {
  source = "../../modules/compute"

  # ... other settings
  cpu_vm_size = "Standard_DS4_v2"  # Change VM size
  cpu_min_nodes = 1                # Change min nodes
  cpu_max_nodes = 8                # Change max nodes
}
```

#### Adjusting networking

```hcl
module "networking" {
  source = "../../modules/networking"

  # ... other settings
  vnet_address_space    = ["10.5.0.0/16"]  # Change CIDR block
  subnet_address_prefix = "10.5.0.0/24"    # Change subnet CIDR
}
```

#### Modifying storage settings

```hcl
module "storage" {
  source = "../../modules/storage"

  # ... other settings
  account_tier             = "Premium"  # Change performance tier
  account_replication_type = "ZRS"      # Change redundancy
}
```

## Troubleshooting

### Common Issues

1. **Authentication Errors**:
   ```
   Error: Error acquiring the state lock: storage: service returned error: StatusCode=403, ErrorCode=AuthenticationFailed
   ```
   Solution: Run `az login` to refresh your authentication

2. **Provider Configuration**:
   ```
   Error: Error: No subscription_id was provided
   ```
   Solution: Ensure your terraform.tfvars file exists and contains subscription_id. This is created using setup.sh but can be overwritten.

3. **Soft-deleted workspace exists**:
   ```
   Error: Soft-deleted workspace exists. Please purge or recover it. https://aka.ms/wsoftdelete
   ```
   Solution: If redeploying, the AML workspace is not deleted by default. Follow instructions in the error for permanent deletion.

4. **Needed registrations:**

Ensure the following providers are registered in your subscription:

- Microsoft.AlertsManagement
- Microsoft.Storage
- Microsoft.Media

### Getting Help

For more detailed troubleshooting:

1. Enable Terraform logging:
   ```bash
   export TF_LOG=DEBUG
   ```

2. Check your Az CLI configuration:
   ```bash
   az account show
   ```

3. Verify Azure role assignments:
   ```bash
   az role assignment list --assignee <your-email>
   ```

## Next Steps

After successfully deploying the infrastructure:

1. Explore the [Azure Machine Learning Workspaces](https://portal.azure.com/#blade/HubsExtension/BrowseResource/resourceType/Microsoft.MachineLearningServices%2Fworkspaces) in the Azure Portal
2. Set up CI/CD pipelines to automate deployments
3. Develop ML pipelines using the deployed infrastructure
