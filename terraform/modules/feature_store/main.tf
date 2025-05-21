resource "random_string" "key_vault_suffix" {
  length  = 5
  special = false
  upper   = false
}

resource "random_string" "container_registry_suffix" {
  length  = 8
  special = false
  upper   = false
}

resource "azurerm_application_insights" "insights" {
  name                = "${var.feature_store_name}-ai"
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = "web"
  tags                = var.tags

  # Prevent Terraform from trying to modify the workspace_id once set
  lifecycle {
    ignore_changes = [
      workspace_id
    ]
  }
}

resource "azurerm_key_vault" "kv" {
  # Use a shortened name to meet the 24-character limit
  # Replace hyphens with empty string to save characters
  name                     = "${replace(var.feature_store_name, "-", "")}kv${random_string.key_vault_suffix.result}"
  location                 = var.location
  resource_group_name      = var.resource_group_name
  tenant_id                = data.azurerm_client_config.current.tenant_id
  sku_name                 = "standard"
  purge_protection_enabled = false

  network_acls {
    default_action = "Allow"
    bypass         = "AzureServices"
  }

  tags = var.tags
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault_access_policy" "terraform" {
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  secret_permissions = [
    "Get", "List", "Set", "Delete", "Recover", "Backup", "Restore", "Purge"
  ]
}

resource "azurerm_container_registry" "acr" {
  name                = "${replace(var.feature_store_name, "-", "")}${random_string.container_registry_suffix.result}"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = true
  tags                = var.tags
}

resource "azurerm_machine_learning_workspace" "feature_store" {
  name                          = var.feature_store_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  application_insights_id       = azurerm_application_insights.insights.id
  key_vault_id                  = azurerm_key_vault.kv.id
  storage_account_id            = var.storage_account_id
  container_registry_id         = azurerm_container_registry.acr.id
  public_network_access_enabled = var.public_network_access_enabled
  kind                          = "FeatureStore"

  feature_store {
    computer_spark_runtime_version = var.spark_version
    offline_connection_name        = var.offline_store_connection_name
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}
