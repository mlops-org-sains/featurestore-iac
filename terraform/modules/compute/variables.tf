variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
}

variable "aml_workspace_name" {
  description = "The name of the Azure Machine Learning workspace"
  type        = string
}

variable "cpu_cluster_name" {
  description = "The name of the CPU compute cluster"
  type        = string
  default     = "cpu-cluster"
}

variable "cpu_vm_size" {
  description = "The VM size for the CPU cluster"
  type        = string
  default     = "Standard_DS3_v2"
}

variable "cpu_min_nodes" {
  description = "The minimum number of nodes in the CPU cluster"
  type        = number
  default     = 0
}

variable "cpu_max_nodes" {
  description = "The maximum number of nodes in the CPU cluster"
  type        = number
  default     = 4
}

variable "subnet_id" {
  description = "The ID of the subnet for compute clusters"
  type        = string
  default     = null
}

variable "idle_seconds_before_scaledown" {
  description = "The number of seconds of idle time before a node is considered for scaledown"
  type        = number
  default     = 900 # 15 minutes
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
