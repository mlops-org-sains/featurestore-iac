# Using azapi provider for Azure ML Registry since it's not available in the azurerm provider yet

terraform {
  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "~> 1.0"
    }
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.resource_group_name}-registry"
  location = var.location
  tags     = var.tags
}

resource "azapi_resource" "ml_registry" {
  type      = "Microsoft.MachineLearningServices/registries@2023-10-01"
  name      = var.registry_name
  location  = var.location
  parent_id = azurerm_resource_group.rg.id

  identity {
    type = "SystemAssigned"
  }

  body = jsonencode({
    properties = {
      regionDetails = [
        {
          location = var.location
          storageAccountDetails = [
            {
              systemCreatedStorageAccount = {
                storageAccountType = var.storage_account_type
              }
            }
          ],
          acrDetails = [
            {
              systemCreatedAcrAccount = {
                acrAccountSku = var.acr_sku
              }
            }
          ]
        }
      ]
    },
    tags = var.tags
  })
}
