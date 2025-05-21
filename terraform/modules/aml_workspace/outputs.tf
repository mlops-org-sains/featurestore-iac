output "workspace_id" {
  description = "The ID of the Machine Learning workspace"
  value       = azurerm_machine_learning_workspace.workspace.id
}

output "workspace_name" {
  description = "The name of the Machine Learning workspace"
  value       = azurerm_machine_learning_workspace.workspace.name
}

output "principal_id" {
  description = "The principal ID of the workspace's system assigned identity"
  value       = azurerm_machine_learning_workspace.workspace.identity[0].principal_id
}

output "key_vault_id" {
  description = "The ID of the key vault"
  value       = azurerm_key_vault.kv.id
}

output "application_insights_id" {
  description = "The ID of the application insights"
  value       = azurerm_application_insights.insights.id
}

output "container_registry_id" {
  description = "The ID of the container registry"
  value       = azurerm_container_registry.acr.id
}

output "container_registry_name" {
  description = "The name of the container registry"
  value       = azurerm_container_registry.acr.name
}
