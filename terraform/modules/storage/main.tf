resource "azurerm_storage_account" "storage" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  is_hns_enabled           = var.is_hns_enabled
  tags                     = var.tags

  network_rules {
    default_action             = "Deny"
    virtual_network_subnet_ids = var.subnet_id != null ? [var.subnet_id] : []
    ip_rules                   = ["0.0.0.0/0"] # Allow all IPs for simplicity, should be restricted in production
    bypass                     = ["AzureServices"]
  }
}

resource "azurerm_storage_container" "data" {
  name                  = "data"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "models" {
  name                  = "models"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "scripts" {
  name                  = "scripts"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}
