terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

# For all environments: Allow users to use assets from the registry
# Grant the Reader role to allow read access to the registry
resource "azurerm_role_assignment" "registry_reader" {
  scope                = var.registry_id
  role_definition_name = "Reader"
  principal_id         = var.workspace_principal_id
}

# For development environment: Grant specific permissions to create and use assets from the registry
resource "azurerm_role_assignment" "registry_contributor" {
  count                = var.environment == "dev" ? 1 : 0
  scope                = var.registry_id
  role_definition_name = "AzureML Registry User"
  principal_id         = var.workspace_principal_id
}
