output "model_registry_id" {
  description = "The ID of the model registry"
  value       = module.model_registry.registry_id
}

output "model_registry_name" {
  description = "The name of the model registry"
  value       = module.model_registry.registry_name
}

output "model_registry_resource_group" {
  description = "The resource group containing the model registry"
  value       = module.model_registry.resource_group_name
}

output "shared_storage_account_id" {
  description = "The ID of the shared storage account"
  value       = module.storage.storage_account_id
}

output "shared_storage_account_name" {
  description = "The name of the shared storage account"
  value       = module.storage.storage_account_name
}

output "shared_resource_group_name" {
  description = "The name of the shared resource group"
  value       = azurerm_resource_group.shared.name
}

output "feature_store_id" {
  description = "The ID of the Feature Store workspace"
  value       = module.feature_store.feature_store_id
}

output "feature_store_name" {
  description = "The name of the Feature Store workspace"
  value       = module.feature_store.feature_store_name
}

output "feature_store_principal_id" {
  description = "The principal ID of the system assigned identity of the Feature Store"
  value       = module.feature_store.principal_id
}
