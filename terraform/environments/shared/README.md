# shared

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | ~> 1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.117.1 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.7.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_feature_store"></a> [feature\_store](#module\_feature\_store) | ../../modules/feature_store | n/a |
| <a name="module_model_registry"></a> [model\_registry](#module\_model\_registry) | ../../modules/model_registry | n/a |
| <a name="module_storage"></a> [storage](#module\_storage) | ../../modules/storage | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.shared](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [random_string.storage_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | The environment (dev, test, prod, shared) | `string` | `"shared"` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where resources will be created | `string` | `"eastus"` | no |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | The Azure subscription ID | `string` | n/a | yes |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | The Azure tenant ID | `string` | n/a | yes |
| <a name="input_tf_state_container"></a> [tf\_state\_container](#input\_tf\_state\_container) | The container name where Terraform state is stored | `string` | `"tfstate"` | no |
| <a name="input_tf_state_resource_group"></a> [tf\_state\_resource\_group](#input\_tf\_state\_resource\_group) | The resource group where Terraform state storage is located | `string` | n/a | yes |
| <a name="input_tf_state_storage_account"></a> [tf\_state\_storage\_account](#input\_tf\_state\_storage\_account) | The storage account name where Terraform state is stored | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_feature_store_id"></a> [feature\_store\_id](#output\_feature\_store\_id) | The ID of the Feature Store workspace |
| <a name="output_feature_store_name"></a> [feature\_store\_name](#output\_feature\_store\_name) | The name of the Feature Store workspace |
| <a name="output_feature_store_principal_id"></a> [feature\_store\_principal\_id](#output\_feature\_store\_principal\_id) | The principal ID of the system assigned identity of the Feature Store |
| <a name="output_model_registry_id"></a> [model\_registry\_id](#output\_model\_registry\_id) | The ID of the model registry |
| <a name="output_model_registry_name"></a> [model\_registry\_name](#output\_model\_registry\_name) | The name of the model registry |
| <a name="output_model_registry_resource_group"></a> [model\_registry\_resource\_group](#output\_model\_registry\_resource\_group) | The resource group containing the model registry |
| <a name="output_shared_resource_group_name"></a> [shared\_resource\_group\_name](#output\_shared\_resource\_group\_name) | The name of the shared resource group |
| <a name="output_shared_storage_account_id"></a> [shared\_storage\_account\_id](#output\_shared\_storage\_account\_id) | The ID of the shared storage account |
| <a name="output_shared_storage_account_name"></a> [shared\_storage\_account\_name](#output\_shared\_storage\_account\_name) | The name of the shared storage account |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
