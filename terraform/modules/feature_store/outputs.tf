output "feature_store_id" {
  description = "The ID of the Feature Store workspace"
  value       = azurerm_machine_learning_workspace.feature_store.id
}

output "feature_store_name" {
  description = "The name of the Feature Store workspace"
  value       = azurerm_machine_learning_workspace.feature_store.name
}

output "principal_id" {
  description = "The principal ID of the system assigned identity of the Feature Store"
  value       = azurerm_machine_learning_workspace.feature_store.identity[0].principal_id
}

output "key_vault_id" {
  description = "The ID of the Key Vault used by the Feature Store"
  value       = azurerm_key_vault.kv.id
}

output "container_registry_id" {
  description = "The ID of the Container Registry used by the Feature Store"
  value       = azurerm_container_registry.acr.id
}
