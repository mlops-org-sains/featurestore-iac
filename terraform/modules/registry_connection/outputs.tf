output "registry_reader_role_id" {
  description = "The ID of the Registry Reader role assignment"
  value       = azurerm_role_assignment.registry_reader.id
}

output "registry_contributor_role_id" {
  description = "The ID of the Registry Contributor role assignment (dev environment only)"
  value       = var.environment == "dev" ? azurerm_role_assignment.registry_contributor[0].id : null
}
