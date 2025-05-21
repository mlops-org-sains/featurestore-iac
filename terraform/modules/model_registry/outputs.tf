output "registry_id" {
  description = "The ID of the model registry"
  value       = azapi_resource.ml_registry.id
}

output "registry_name" {
  description = "The name of the model registry"
  value       = azapi_resource.ml_registry.name
}

output "resource_group_name" {
  description = "The name of the resource group containing the model registry"
  value       = azurerm_resource_group.rg.name
}
