# Azure ML Feature Store Module

This module creates an Azure Machine Learning Feature Store workspace with its supporting resources.

## Description

The Feature Store is a specialized Azure ML workspace that provides capabilities for feature management, storage, and serving. It enables data scientists and ML engineers to discover, share, and reuse features across ML models.
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_application_insights.insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights) | resource |
| [azurerm_container_registry.acr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry) | resource |
| [azurerm_key_vault.kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_key_vault_access_policy.terraform](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_machine_learning_workspace.feature_store](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_workspace) | resource |
| [random_string.container_registry_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [random_string.key_vault_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_feature_store_name"></a> [feature\_store\_name](#input\_feature\_store\_name) | The name of the Azure Machine Learning Feature Store | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where resources will be created | `string` | n/a | yes |
| <a name="input_offline_store_connection_name"></a> [offline\_store\_connection\_name](#input\_offline\_store\_connection\_name) | The name of the offline store connection | `string` | `"DefaultOfflineStoreConnection"` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Flag to indicate whether to enable public network access | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group | `string` | n/a | yes |
| <a name="input_spark_version"></a> [spark\_version](#input\_spark\_version) | The Spark runtime version for feature store compute | `string` | `"3.3"` | no |
| <a name="input_storage_account_id"></a> [storage\_account\_id](#input\_storage\_account\_id) | The ID of the storage account | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_container_registry_id"></a> [container\_registry\_id](#output\_container\_registry\_id) | The ID of the Container Registry used by the Feature Store |
| <a name="output_feature_store_id"></a> [feature\_store\_id](#output\_feature\_store\_id) | The ID of the Feature Store workspace |
| <a name="output_feature_store_name"></a> [feature\_store\_name](#output\_feature\_store\_name) | The name of the Feature Store workspace |
| <a name="output_key_vault_id"></a> [key\_vault\_id](#output\_key\_vault\_id) | The ID of the Key Vault used by the Feature Store |
| <a name="output_principal_id"></a> [principal\_id](#output\_principal\_id) | The principal ID of the system assigned identity of the Feature Store |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
