variable "workspace_id" {
  description = "The ID of the Azure Machine Learning workspace"
  type        = string
}

variable "workspace_name" {
  description = "The name of the Azure Machine Learning workspace"
  type        = string
}

variable "workspace_resource_group_name" {
  description = "The resource group name of the Azure Machine Learning workspace"
  type        = string
}

variable "registry_id" {
  description = "The ID of the Azure Machine Learning registry"
  type        = string
}

variable "registry_name" {
  description = "The name of the Azure Machine Learning registry"
  type        = string
}

variable "registry_resource_group_name" {
  description = "The resource group name of the Azure Machine Learning registry"
  type        = string
}

variable "workspace_principal_id" {
  description = "The principal ID of the workspace's system assigned identity"
  type        = string
}

variable "connection_name" {
  description = "The name of the registry connection"
  type        = string
  default     = "shared-registry-connection"
}

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "environment" {
  description = "The environment name (dev, test, prod) - used to determine role assignments"
  type        = string
}
