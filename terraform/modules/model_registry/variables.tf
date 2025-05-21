variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
}

variable "registry_name" {
  description = "The name of the model registry"
  type        = string
}

variable "storage_account_type" {
  description = "The type of storage account to use for the registry"
  type        = string
  default     = "Standard_LRS"
}

variable "acr_sku" {
  description = "The SKU of the Azure Container Registry to use for the registry"
  type        = string
  default     = "Premium"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
