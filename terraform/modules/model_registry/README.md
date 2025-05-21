# Azure ML Model Registry Module

This module provisions an Azure Machine Learning Registry for model management across environments.

## Resources Created

- Azure Resource Group for Registry
- Azure Machine Learning Registry (using azapi provider)

## Usage

```hcl
module "model_registry" {
  source = "../../modules/model_registry"

  resource_group_name  = azurerm_resource_group.shared.name
  location             = azurerm_resource_group.shared.location
  registry_name        = "mlops-registry"
  storage_account_type = "Standard_LRS"
  acr_sku              = "Premium"
  tags                 = local.tags
}
```

## Note

This README will be automatically updated using terraform-docs.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | ~> 1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azapi"></a> [azapi](#provider\_azapi) | ~> 1.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azapi_resource.ml_registry](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/resource) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acr_sku"></a> [acr\_sku](#input\_acr\_sku) | The SKU of the Azure Container Registry to use for the registry | `string` | `"Premium"` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where resources will be created | `string` | n/a | yes |
| <a name="input_registry_name"></a> [registry\_name](#input\_registry\_name) | The name of the model registry | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group | `string` | n/a | yes |
| <a name="input_storage_account_type"></a> [storage\_account\_type](#input\_storage\_account\_type) | The type of storage account to use for the registry | `string` | `"Standard_LRS"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_registry_id"></a> [registry\_id](#output\_registry\_id) | The ID of the model registry |
| <a name="output_registry_name"></a> [registry\_name](#output\_registry\_name) | The name of the model registry |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The name of the resource group containing the model registry |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
