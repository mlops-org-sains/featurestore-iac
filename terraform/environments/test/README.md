# test

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | ~> 1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.117.1 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.7.2 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aml_workspace"></a> [aml\_workspace](#module\_aml\_workspace) | ../../modules/aml_workspace | n/a |
| <a name="module_compute"></a> [compute](#module\_compute) | ../../modules/compute | n/a |
| <a name="module_registry_connection"></a> [registry\_connection](#module\_registry\_connection) | ../../modules/registry_connection | n/a |
| <a name="module_storage"></a> [storage](#module\_storage) | ../../modules/storage | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.compute_to_fs_storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.compute_to_registry_ds](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.compute_to_registry_user](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.compute_to_workspace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.workspace_to_feature_store](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.workspace_to_fs_storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [random_string.storage_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [terraform_remote_state.shared](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_costcentre"></a> [costcentre](#input\_costcentre) | Cost center for billing | `string` | n/a | yes |
| <a name="input_dataClassification"></a> [dataClassification](#input\_dataClassification) | Classification of data stored | `string` | n/a | yes |
| <a name="input_dataRetention"></a> [dataRetention](#input\_dataRetention) | Data retention period | `string` | n/a | yes |
| <a name="input_email"></a> [email](#input\_email) | Contact email for the resources | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment (dev, test, prod, shared) | `string` | `"test"` | no |
| <a name="input_live"></a> [live](#input\_live) | Indicates if the resource is live | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where resources will be created | `string` | `"eastus"` | no |
| <a name="input_servicecatalogueID"></a> [servicecatalogueID](#input\_servicecatalogueID) | Service catalogue ID | `string` | n/a | yes |
| <a name="input_servicename"></a> [servicename](#input\_servicename) | Name of the service | `string` | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | The Azure subscription ID | `string` | n/a | yes |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | The Azure tenant ID | `string` | n/a | yes |
| <a name="input_tf_state_container"></a> [tf\_state\_container](#input\_tf\_state\_container) | The container name where Terraform state is stored | `string` | `"tfstate"` | no |
| <a name="input_tf_state_resource_group"></a> [tf\_state\_resource\_group](#input\_tf\_state\_resource\_group) | The resource group where Terraform state storage is located | `string` | n/a | yes |
| <a name="input_tf_state_storage_account"></a> [tf\_state\_storage\_account](#input\_tf\_state\_storage\_account) | The storage account name where Terraform state is stored | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cpu_cluster_name"></a> [cpu\_cluster\_name](#output\_cpu\_cluster\_name) | The name of the CPU compute cluster |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The name of the resource group |
| <a name="output_storage_account_name"></a> [storage\_account\_name](#output\_storage\_account\_name) | The name of the storage account |
| <a name="output_workspace_id"></a> [workspace\_id](#output\_workspace\_id) | The ID of the Machine Learning workspace |
| <a name="output_workspace_name"></a> [workspace\_name](#output\_workspace\_name) | The name of the Machine Learning workspace |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
