# Azure Machine Learning Workspace Module

This module provisions an Azure Machine Learning Workspace with associated resources.

## Resources Created

- Azure Machine Learning Workspace
- Azure Application Insights
- Azure Key Vault
- Azure Container Registry
- Key Vault Access Policy for Terraform service principal

## Usage

```hcl
module "aml_workspace" {
  source = "../../modules/aml_workspace"

  resource_group_name            = azurerm_resource_group.rg.name
  location                       = azurerm_resource_group.rg.location
  workspace_name                 = "my-aml-workspace"
  storage_account_id             = module.storage.storage_account_id
  key_vault_id                   = null # Will be created by the module
  application_insights_id        = null # Will be created by the module
  container_registry_id          = null # Will be created by the module
  public_network_access_enabled  = true
  tags                           = local.tags
}
```

## Note

This README will be automatically updated using terraform-docs.

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
| [azurerm_machine_learning_workspace.workspace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_workspace) | resource |
| [random_string.container_registry_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [random_string.key_vault_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_workspace_contributors"></a> [additional\_workspace\_contributors](#input\_additional\_workspace\_contributors) | List of principal IDs to grant AzureML Data Scientist access to the workspace | `list(string)` | `[]` | no |
| <a name="input_additional_workspace_readers"></a> [additional\_workspace\_readers](#input\_additional\_workspace\_readers) | List of principal IDs to grant Reader access to the workspace | `list(string)` | `[]` | no |
| <a name="input_application_insights_id"></a> [application\_insights\_id](#input\_application\_insights\_id) | The ID of the application insights | `string` | n/a | yes |
| <a name="input_container_registry_id"></a> [container\_registry\_id](#input\_container\_registry\_id) | The ID of the container registry | `string` | `null` | no |
| <a name="input_image_build_compute_name"></a> [image\_build\_compute\_name](#input\_image\_build\_compute\_name) | The name of the compute cluster for image building | `string` | `"image-builder"` | no |
| <a name="input_key_vault_id"></a> [key\_vault\_id](#input\_key\_vault\_id) | The ID of the key vault | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where resources will be created | `string` | n/a | yes |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Flag to indicate whether to enable public network access | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group | `string` | n/a | yes |
| <a name="input_storage_account_id"></a> [storage\_account\_id](#input\_storage\_account\_id) | The ID of the storage account | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_user_principal_ids"></a> [user\_principal\_ids](#input\_user\_principal\_ids) | List of user/service principal object IDs to grant workspace access | `list(string)` | `[]` | no |
| <a name="input_workspace_name"></a> [workspace\_name](#input\_workspace\_name) | The name of the Azure Machine Learning workspace | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_application_insights_id"></a> [application\_insights\_id](#output\_application\_insights\_id) | The ID of the application insights |
| <a name="output_container_registry_id"></a> [container\_registry\_id](#output\_container\_registry\_id) | The ID of the container registry |
| <a name="output_container_registry_name"></a> [container\_registry\_name](#output\_container\_registry\_name) | The name of the container registry |
| <a name="output_key_vault_id"></a> [key\_vault\_id](#output\_key\_vault\_id) | The ID of the key vault |
| <a name="output_principal_id"></a> [principal\_id](#output\_principal\_id) | The principal ID of the workspace's system assigned identity |
| <a name="output_workspace_id"></a> [workspace\_id](#output\_workspace\_id) | The ID of the Machine Learning workspace |
| <a name="output_workspace_name"></a> [workspace\_name](#output\_workspace\_name) | The name of the Machine Learning workspace |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
