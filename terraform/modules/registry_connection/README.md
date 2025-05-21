# Registry Connection Module

This module manages Azure RBAC permissions to allow workspaces to access the central Azure ML Registry.

## Overview

The registry connection module sets up role-based access control (RBAC) permissions between Azure Machine Learning workspaces and a shared model registry. It grants:

- **Reader** role to all environments - Allows workspaces to read and use models from the registry
- **Contributor** role to development environment only - Allows the dev workspace to create and update models in the registry

## Usage

```hcl
module "registry_connection" {
  source = "../../modules/registry_connection"

  workspace_id                  = module.aml_workspace.workspace_id
  workspace_name                = module.aml_workspace.workspace_name
  workspace_resource_group_name = azurerm_resource_group.rg.name
  workspace_principal_id        = module.aml_workspace.principal_id

  registry_id                  = data.terraform_remote_state.shared.outputs.model_registry_id
  registry_name                = data.terraform_remote_state.shared.outputs.model_registry_name
  registry_resource_group_name = data.terraform_remote_state.shared.outputs.model_registry_resource_group

  environment     = "dev"  # Can be "dev", "test", or "prod"
  connection_name = "shared-registry-connection"
  location        = var.location
  tags            = local.tags
}
```
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_role_assignment.registry_contributor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.registry_reader](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_connection_name"></a> [connection\_name](#input\_connection\_name) | The name of the registry connection | `string` | `"shared-registry-connection"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment name (dev, test, prod) - used to determine role assignments | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where resources will be created | `string` | n/a | yes |
| <a name="input_registry_id"></a> [registry\_id](#input\_registry\_id) | The ID of the Azure Machine Learning registry | `string` | n/a | yes |
| <a name="input_registry_name"></a> [registry\_name](#input\_registry\_name) | The name of the Azure Machine Learning registry | `string` | n/a | yes |
| <a name="input_registry_resource_group_name"></a> [registry\_resource\_group\_name](#input\_registry\_resource\_group\_name) | The resource group name of the Azure Machine Learning registry | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_workspace_id"></a> [workspace\_id](#input\_workspace\_id) | The ID of the Azure Machine Learning workspace | `string` | n/a | yes |
| <a name="input_workspace_name"></a> [workspace\_name](#input\_workspace\_name) | The name of the Azure Machine Learning workspace | `string` | n/a | yes |
| <a name="input_workspace_principal_id"></a> [workspace\_principal\_id](#input\_workspace\_principal\_id) | The principal ID of the workspace's system assigned identity | `string` | n/a | yes |
| <a name="input_workspace_resource_group_name"></a> [workspace\_resource\_group\_name](#input\_workspace\_resource\_group\_name) | The resource group name of the Azure Machine Learning workspace | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_registry_contributor_role_id"></a> [registry\_contributor\_role\_id](#output\_registry\_contributor\_role\_id) | The ID of the Registry Contributor role assignment (dev environment only) |
| <a name="output_registry_reader_role_id"></a> [registry\_reader\_role\_id](#output\_registry\_reader\_role\_id) | The ID of the Registry Reader role assignment |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
