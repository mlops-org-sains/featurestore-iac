variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
}

variable "feature_store_name" {
  description = "The name of the Azure Machine Learning Feature Store"
  type        = string
}

variable "storage_account_id" {
  description = "The ID of the storage account"
  type        = string
}

variable "public_network_access_enabled" {
  description = "Flag to indicate whether to enable public network access"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "spark_version" {
  description = "The Spark runtime version for feature store compute"
  type        = string
  default     = "3.3"
}

variable "offline_store_connection_name" {
  description = "The name of the offline store connection"
  type        = string
  default     = "DefaultOfflineStoreConnection"
}

variable "enable_application_insights" {
  description = "Flag to indicate whether to create Application Insights"
  type        = bool
  default     = false
}
