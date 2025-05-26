variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
}

variable "workspace_name" {
  description = "The name of the Azure Machine Learning workspace"
  type        = string
}

variable "storage_account_id" {
  description = "The ID of the storage account"
  type        = string
}

variable "key_vault_id" {
  description = "The ID of the key vault"
  type        = string
}

variable "application_insights_id" {
  description = "The ID of the application insights"
  type        = string
}

variable "container_registry_id" {
  description = "The ID of the container registry"
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "public_network_access_enabled" {
  description = "Flag to indicate whether to enable public network access"
  type        = bool
  default     = true
}

variable "image_build_compute_name" {
  description = "The name of the compute cluster for image building"
  type        = string
  default     = "image-builder"
}

variable "user_principal_ids" {
  description = "List of user/service principal object IDs to grant workspace access"
  type        = list(string)
  default     = []
}

variable "additional_workspace_readers" {
  description = "List of principal IDs to grant Reader access to the workspace"
  type        = list(string)
  default     = []
}

variable "additional_workspace_contributors" {
  description = "List of principal IDs to grant AzureML Data Scientist access to the workspace"
  type        = list(string)
  default     = []
}
