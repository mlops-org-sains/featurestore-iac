output "workspace_id" {
  description = "The ID of the Machine Learning workspace"
  value       = module.aml_workspace.workspace_id
}

output "workspace_name" {
  description = "The name of the Machine Learning workspace"
  value       = module.aml_workspace.workspace_name
}

output "resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.rg.name
}

output "storage_account_name" {
  description = "The name of the storage account"
  value       = module.storage.storage_account_name
}

output "cpu_cluster_name" {
  description = "The name of the CPU compute cluster"
  value       = module.compute.cpu_cluster_name
}
