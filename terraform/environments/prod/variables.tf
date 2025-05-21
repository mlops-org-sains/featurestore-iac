variable "subscription_id" {
  description = "The Azure subscription ID"
  type        = string
}

variable "tenant_id" {
  description = "The Azure tenant ID"
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
  default     = "eastus"
}

variable "environment" {
  description = "The environment (dev, test, prod, shared)"
  type        = string
  default     = "prod"
}

variable "tf_state_resource_group" {
  description = "The resource group where Terraform state storage is located"
  type        = string
}

variable "tf_state_storage_account" {
  description = "The storage account name where Terraform state is stored"
  type        = string
}

variable "tf_state_container" {
  description = "The container name where Terraform state is stored"
  type        = string
  default     = "tfstate"
}
