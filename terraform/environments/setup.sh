#!/bin/bash
set -e

# This script creates the Azure resources needed for Terraform state management
# and initializes each environment with the remote backend configuration.

# Check if Azure CLI is installed
if ! command -v az &> /dev/null; then
    echo "Azure CLI is not installed. Please install it first."
    exit 1
fi

# Check if logged in to Azure
echo "Checking Azure login status..."
az account show &> /dev/null || { echo "Please login to Azure using 'az login'"; az login; }

# Get subscription ID
SUBSCRIPTION_ID=$(az account show --query id -o tsv)
TENANT_ID=$(az account show --query tenantId -o tsv)

echo "Using Subscription ID: $SUBSCRIPTION_ID"
echo "Using Tenant ID: $TENANT_ID"

# Set the subscription context explicitly
echo "Setting subscription context..."
az account set --subscription "$SUBSCRIPTION_ID"

# Create resource group for Terraform state
echo "Creating resource group for Terraform state..."
RESOURCE_GROUP="terraform"
LOCATION="eastus"
az group create --name $RESOURCE_GROUP --location $LOCATION

# Create storage account for Terraform state
echo "Creating storage account for Terraform state..."
STORAGE_ACCOUNT="terraformmlops$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 8 | head -n 1)"
az storage account create --name $STORAGE_ACCOUNT --resource-group $RESOURCE_GROUP --sku Standard_LRS

# Create container for state files
echo "Creating container for state files..."
az storage container create --name tfstate --account-name $STORAGE_ACCOUNT

# Get current user object ID for role assignment
echo "Getting current user details..."
USER_OBJECT_ID=$(az ad signed-in-user show --query id -o tsv)

# Assign Storage Blob Data Contributor role to the current user
echo "Assigning Storage Blob Data Contributor role to current user..."
az role assignment create \
  --role "Storage Blob Data Contributor" \
  --assignee-object-id "$USER_OBJECT_ID" \
  --assignee-principal-type User \
  --scope "subscriptions/$SUBSCRIPTION_ID/resourceGroups/$RESOURCE_GROUP/providers/Microsoft.Storage/storageAccounts/$STORAGE_ACCOUNT"
  #--scope "/subscriptions/$SUBSCRIPTION_ID/resourceGroups/$RESOURCE_GROUP/providers/Microsoft.Storage/storageAccounts/$STORAGE_ACCOUNT" - if the above doesn't work then delete the line and uncomment this one

# Wait for role assignment to propagate
echo "Waiting for RBAC role assignment to propagate (30 seconds)..."
sleep 30

# Create terraform.tfvars files for each environment
create_tfvars() {
    local ENV=$1
    local TFVARS_FILE="terraform/environments/$ENV/terraform.tfvars"

    echo "Creating $TFVARS_FILE..."
    cat > $TFVARS_FILE << EOF
subscription_id      = "$SUBSCRIPTION_ID"
tenant_id            = "$TENANT_ID"
environment          = "$ENV"
tf_state_resource_group = "$RESOURCE_GROUP"
tf_state_storage_account = "$STORAGE_ACCOUNT"
tf_state_container   = "tfstate"
EOF
}

# Update backend configuration files
update_backend() {
    local ENV=$1
    local BACKEND_FILE="terraform/environments/$ENV/backend.tf"

    echo "Updating $BACKEND_FILE..."
    cat > $BACKEND_FILE << EOF
terraform {
  backend "azurerm" {
    resource_group_name  = "$RESOURCE_GROUP"
    storage_account_name = "$STORAGE_ACCOUNT"
    container_name       = "tfstate"
    key                  = "env/$ENV.tfstate"
    use_azuread_auth     = true
  }
}
EOF
}

# Create tfvars and update backend for each environment
for ENV in shared dev test prod; do
    create_tfvars $ENV
    update_backend $ENV
done

echo "Setup complete. Storage account name: $STORAGE_ACCOUNT"
echo ""
echo "Initializing Terraform environments..."

# Clean up existing Terraform directories and lock files before initializing
echo "Cleaning up existing Terraform state directories..."
for ENV in shared dev test prod; do
    echo "Cleaning up $ENV environment..."
    rm -rf "terraform/environments/$ENV/.terraform"
    rm -f "terraform/environments/$ENV/.terraform.lock.hcl"
done

# Initialize each environment
for ENV in shared dev test prod; do
    echo "Initializing $ENV environment..."
    cd "terraform/environments/$ENV"

    terraform init -reconfigure -upgrade

    cd ../../../
done

echo ""
echo "All environments initialized."
echo ""
echo "Next steps:"
echo "1. Deploy shared environment:   cd terraform/environments/shared && terraform apply"
echo "2. Deploy dev environment:      cd terraform/environments/dev && terraform apply"
echo "3. Deploy test environment:     cd terraform/environments/test && terraform apply"
echo "4. Deploy prod environment:     cd terraform/environments/prod && terraform apply"
