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
  default     = "test"
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

# Required tags
variable "email" {
  description = "Contact email for the resources"
  type        = string
}

variable "costcentre" {
  description = "Cost center for billing"
  type        = string
}

variable "live" {
  description = "Indicates if the resource is live"
  type        = string
}

variable "servicename" {
  description = "Name of the service"
  type        = string
}

variable "servicecatalogueID" {
  description = "Service catalogue ID"
  type        = string
}

variable "dataRetention" {
  description = "Data retention period"
  type        = string
}

variable "dataClassification" {
  description = "Classification of data stored"
  type        = string
}
