output "cpu_cluster_id" {
  description = "The ID of the CPU compute cluster"
  value       = azurerm_machine_learning_compute_cluster.cpu.id
}

output "cpu_cluster_name" {
  description = "The name of the CPU compute cluster"
  value       = azurerm_machine_learning_compute_cluster.cpu.name
}
