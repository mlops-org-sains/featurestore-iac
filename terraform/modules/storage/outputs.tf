output "storage_account_id" {
  description = "The ID of the storage account"
  value       = azurerm_storage_account.storage.id
}

output "storage_account_name" {
  description = "The name of the storage account"
  value       = azurerm_storage_account.storage.name
}

output "primary_access_key" {
  description = "The primary access key for the storage account"
  value       = azurerm_storage_account.storage.primary_access_key
  sensitive   = true
}

output "primary_connection_string" {
  description = "The primary connection string for the storage account"
  value       = azurerm_storage_account.storage.primary_connection_string
  sensitive   = true
}

output "data_container_name" {
  description = "The name of the data container"
  value       = azurerm_storage_container.data.name
}

output "models_container_name" {
  description = "The name of the models container"
  value       = azurerm_storage_container.models.name
}

output "scripts_container_name" {
  description = "The name of the scripts container"
  value       = azurerm_storage_container.scripts.name
}
