resource "azurerm_machine_learning_compute_cluster" "cpu" {
  name                          = var.cpu_cluster_name
  location                      = var.location
  vm_priority                   = "Dedicated"
  vm_size                       = var.cpu_vm_size
  machine_learning_workspace_id = var.aml_workspace_name
  subnet_resource_id            = var.subnet_id

  scale_settings {
    min_node_count                       = var.cpu_min_nodes
    max_node_count                       = var.cpu_max_nodes
    scale_down_nodes_after_idle_duration = "PT${var.idle_seconds_before_scaledown}S"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}
