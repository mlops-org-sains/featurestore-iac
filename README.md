# Azure MLOps Terraform Infrastructure

This directory contains the Terraform code for deploying the Azure MLOps infrastructure.

## Setup & Prerequisites

1. **Run the terraform code in Windows laptop**
    - Requires VSCode in laptop

2. **Install VSCode**
   - If VSCode is not available, please download and install it: [Download VSCode](https://code.visualstudio.com/download)

3. **Install Git to clone the github repo**
   - Follow the instructions to install Git: [Install Git](https://www.windowscentral.com/how-clone-github-repos-windows-10-11-and-wsl)

4. **Check Installed Libraries**
   - Open the CMD or Git Bash Terminal to check if the following libraries are installed:
   ```
    terraform -version
    ```

5. **Install Terraform (if not installed)**
   - Follow the appropriate OS installation instructions:
     - [Terraform on Windows](https://learn.microsoft.com/en-us/azure/developer/terraform/get-started-windows-bash)
     - [Terraform Installation Guide](https://developer.hashicorp.com/terraform/install)

6. **Check Azure CLI Installation**
   - Ensure Azure CLI is installed: [Install Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-windows?view=azure-cli-latest&pivots=winget)
   - If required, run
   ```
   az upgrade
   ```

7. **Login to Your Subscription**
   - Use the following command to login:
   ```
   az login
   ```

8. **Run the Code Using Git Bash Terminal**
   - Make the script executable in VS Code:
     - Open the terminal (`Ctrl + ` or Terminal > New Terminal).
     - Click the dropdown in the terminal tab and select Git Bash.
     - Run the command:
     ```
     chmod +x terraform/environments/setup.sh
     ```

## State Management

Terraform state is managed in Azure Storage with separate state files for each environment to enable isolation and parallel deployments.

9. Ensure the following providers are registered for your subscription (non-exhaustive list):
    - Microsoft.AlertsManagement
    - Microsoft.Storage

    You can check this by running:
    ```
    az provider list --query "[?contains(['Microsoft.AlertsManagement', 'Microsoft.Storage'], namespace)].{Provider:namespace, State:registrationState}" -o table
    ```

    If any provider is "NotRegistered", register it using:

    ```
    az provider register --namespace PROVIDER_NAME
    ```

10. Run the provided setup script to create the Terraform state resources and initialize each environment:

    ```bash
    # Make the script executable
    chmod +x terraform/environments/setup.sh

    # Run the setup script
    ./terraform/environments/setup.sh
    ```

    This script will:
    - Create a resource group for Terraform state
    - Create an Azure Storage account for state files
    - Create a container for state files
    - Configure each environment with the correct backend
    - Create terraform.tfvars files with your subscription ID and tenant ID
    - Initialize Terraform for each environment

    More information is available in [`./docs/Terraform-Setup.md`](./docs/Terraform-Setup.md).s

### Environments

The infrastructure is separated into four environments:

1. **Shared** - Contains the model registry and other shared resources
2. **Development** - Development environment for experimentation
3. **Test** - Testing environment for validation
4. **Production** - Production environment for serving models

### Deployment Order

Deploy the environments in the following order:

```bash
# 1. Deploy shared resources
cd terraform/environments/shared
terraform apply

# 2. Deploy development environment
cd ../dev
terraform apply

# 3. Deploy test environment
cd ../test
terraform apply

# 4. Deploy production environment
cd ../prod
terraform apply
```

## Architecture

Each environment has:
- A dedicated Resource Group
- Virtual Network with custom address spaces
- Storage Account
- Azure Machine Learning Workspace
- Compute Clusters

The shared environment contains the central Model Registry that is referenced by all other environments.

## Configuration

Environment-specific configuration is handled through variables in the `terraform.tfvars` files. Essential variables include:

- `subscription_id` - Azure subscription ID
- `tenant_id` - Azure tenant ID
- `location` - Azure region
- `environment` - Environment name (shared, dev, test, prod)

## Modules

The infrastructure is organized into reusable modules:

- `aml_workspace` - Azure Machine Learning workspace
- `compute` - AML compute clusters
- `model_registry` - Model registry configuration
- `networking` - VNet, subnet, NSG
- `storage` - Storage accounts

## Customization

To customize the deployment:

1. Modify the `terraform.tfvars` files
2. Update module parameters in the environment's `main.tf`
3. Run `terraform plan` to verify changes
4. Apply the changes with `terraform apply`
