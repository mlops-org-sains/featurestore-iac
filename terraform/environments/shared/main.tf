terraform {
  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "~> 1.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

locals {
  prefix = "mlops"
  tags = {
    Environment = title(var.environment)
    Project     = "MLOps Accelerator"
    Terraform   = "true"
  }
}

resource "azurerm_resource_group" "shared" {
  name     = "${local.prefix}-shared-rg"
  location = var.location
  tags     = local.tags
}

# Generate a random string for storage account name uniqueness
resource "random_string" "storage_suffix" {
  length  = 8
  special = false
  upper   = false
}

# Storage account for the shared model registry
module "storage" {
  source = "../../modules/storage"

  resource_group_name      = azurerm_resource_group.shared.name
  location                 = azurerm_resource_group.shared.location
  storage_account_name     = "${replace(local.prefix, "-", "")}registry${random_string.storage_suffix.result}"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  is_hns_enabled           = false
  tags                     = local.tags
}

# Model registry using the azapi resource
module "model_registry" {
  source = "../../modules/model_registry"

  resource_group_name  = azurerm_resource_group.shared.name
  location             = azurerm_resource_group.shared.location
  registry_name        = "${local.prefix}-registry"
  storage_account_type = "Standard_LRS"
  acr_sku              = "Premium"
  tags                 = local.tags
}

# Feature Store for shared feature management
module "feature_store" {
  source = "../../modules/feature_store"

  resource_group_name           = azurerm_resource_group.shared.name
  location                      = azurerm_resource_group.shared.location
  feature_store_name            = "${local.prefix}-shared-fs"
  storage_account_id            = module.storage.storage_account_id
  public_network_access_enabled = true
  spark_version                 = "3.3"
  offline_store_connection_name = "DefaultOfflineStoreConnection"
  tags                          = local.tags
}
