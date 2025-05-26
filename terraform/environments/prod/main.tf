terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = "~> 1.0"
    }
  }
}

data "terraform_remote_state" "shared" {
  backend = "azurerm"

  config = {
    resource_group_name  = var.tf_state_resource_group
    storage_account_name = var.tf_state_storage_account
    container_name       = var.tf_state_container
    key                  = "env/shared.tfstate"
    use_azuread_auth     = true
  }
}

# Generate a random string for storage account name uniqueness
resource "random_string" "storage_suffix" {
  length  = 8
  special = false
  upper   = false
}

locals {
  prefix = "ml" # Shortened from "mlops" to avoid naming limits
  env    = var.environment
  tags = {
    Environment        = title(var.environment)
    Project            = "MLOps Accelerator"
    Terraform          = "true"
    email              = var.email
    costcentre         = var.costcentre
    live               = var.live
    servicename        = var.servicename
    servicecatalogueID = var.servicecatalogueID
    dataRetention      = var.dataRetention
    dataClassification = var.dataClassification
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "${local.prefix}-${local.env}-rg"
  location = var.location
  tags     = local.tags
}

# module "networking" {
#   source = "../../modules/networking"

#   resource_group_name   = azurerm_resource_group.rg.name
#   location              = azurerm_resource_group.rg.location
#   vnet_name             = "${local.prefix}-${local.env}-vnet"
#   vnet_address_space    = ["10.2.0.0/16"]
#   subnet_name           = "${local.prefix}-${local.env}-subnet"
#   subnet_address_prefix = "10.2.0.0/24"
#   tags                  = local.tags
# }

module "storage" {
  source = "../../modules/storage"

  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  storage_account_name     = "${replace(local.prefix, "-", "")}${local.env}${random_string.storage_suffix.result}"
  account_tier             = "Standard"
  account_replication_type = "GRS" # Geographic redundancy for production
  is_hns_enabled           = false # Set to false for Azure ML compatibility
  subnet_id                = null  # module.networking.subnet_id
  tags                     = local.tags
}

module "aml_workspace" {
  source = "../../modules/aml_workspace"

  resource_group_name           = azurerm_resource_group.rg.name
  location                      = azurerm_resource_group.rg.location
  workspace_name                = "${local.prefix}-${local.env}-ws"
  storage_account_id            = module.storage.storage_account_id
  key_vault_id                  = null # Will be created by the module
  application_insights_id       = null # Will be created by the module
  container_registry_id         = null # Will be created by the module
  public_network_access_enabled = true # WORKSHOP: Enabled for cross-environment demo
  tags                          = local.tags
}

module "compute" {
  source = "../../modules/compute"

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  aml_workspace_name  = module.aml_workspace.workspace_id
  cpu_cluster_name    = "${local.prefix}-${local.env}-cpu"
  cpu_vm_size         = "Standard_DS4_v2" # Larger VMs for production
  cpu_min_nodes       = 0
  cpu_max_nodes       = 4    # More capacity for production
  subnet_id           = null # module.networking.subnet_id
  tags                = local.tags
}

# Connect the workspace to the shared model registry
module "registry_connection" {
  source = "../../modules/registry_connection"

  workspace_id                  = module.aml_workspace.workspace_id
  workspace_name                = module.aml_workspace.workspace_name
  workspace_resource_group_name = azurerm_resource_group.rg.name
  workspace_principal_id        = module.aml_workspace.principal_id

  registry_id                  = data.terraform_remote_state.shared.outputs.model_registry_id
  registry_name                = data.terraform_remote_state.shared.outputs.model_registry_name
  registry_resource_group_name = data.terraform_remote_state.shared.outputs.model_registry_resource_group

  connection_name = "shared-registry-connection"
  location        = var.location
  tags            = local.tags
  environment     = var.environment
}

# Feature Store Access Control
# Grant workspace access to shared feature store
resource "azurerm_role_assignment" "workspace_to_feature_store" {
  scope                = data.terraform_remote_state.shared.outputs.feature_store_id
  role_definition_name = "AzureML Data Scientist"
  principal_id         = module.aml_workspace.principal_id
}

# Grant workspace access to shared feature store storage
resource "azurerm_role_assignment" "workspace_to_fs_storage" {
  scope                = data.terraform_remote_state.shared.outputs.shared_storage_account_id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = module.aml_workspace.principal_id
}

# Grant compute cluster access to shared feature store storage
resource "azurerm_role_assignment" "compute_to_fs_storage" {
  scope                = data.terraform_remote_state.shared.outputs.shared_storage_account_id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = module.compute.compute_principal_id
}

# Compute Cluster Access Control
# Grant compute cluster Contributor access to local workspace
resource "azurerm_role_assignment" "compute_to_workspace" {
  scope                = module.aml_workspace.workspace_id
  role_definition_name = "Contributor"
  principal_id         = module.compute.compute_principal_id
}

# Grant compute cluster Registry User access to shared registry
resource "azurerm_role_assignment" "compute_to_registry_user" {
  scope                = data.terraform_remote_state.shared.outputs.model_registry_id
  role_definition_name = "AzureML Registry User"
  principal_id         = module.compute.compute_principal_id
}

# Grant compute cluster Data Scientist access to shared registry
resource "azurerm_role_assignment" "compute_to_registry_ds" {
  scope                = data.terraform_remote_state.shared.outputs.model_registry_id
  role_definition_name = "AzureML Data Scientist"
  principal_id         = module.compute.compute_principal_id
}
