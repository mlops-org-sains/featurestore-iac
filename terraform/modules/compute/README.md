# Azure ML Compute Module

This module provisions an Azure Machine Learning compute cluster for running machine learning workloads.

## Resources Created

- Azure Machine Learning Compute Cluster (CPU)

## Usage

```hcl
module "compute" {
  source = "../../modules/compute"

  resource_group_name  = azurerm_resource_group.rg.name
  location             = azurerm_resource_group.rg.location
  aml_workspace_name   = module.aml_workspace.workspace_id
  cpu_cluster_name     = "cpu-cluster"
  cpu_vm_size          = "Standard_DS3_v2"
  cpu_min_nodes        = 0
  cpu_max_nodes        = 2
  subnet_id            = module.networking.subnet_id
  tags                 = local.tags
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

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_machine_learning_compute_cluster.cpu](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_compute_cluster) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aml_workspace_name"></a> [aml\_workspace\_name](#input\_aml\_workspace\_name) | The name of the Azure Machine Learning workspace | `string` | n/a | yes |
| <a name="input_cpu_cluster_name"></a> [cpu\_cluster\_name](#input\_cpu\_cluster\_name) | The name of the CPU compute cluster | `string` | `"cpu-cluster"` | no |
| <a name="input_cpu_max_nodes"></a> [cpu\_max\_nodes](#input\_cpu\_max\_nodes) | The maximum number of nodes in the CPU cluster | `number` | `4` | no |
| <a name="input_cpu_min_nodes"></a> [cpu\_min\_nodes](#input\_cpu\_min\_nodes) | The minimum number of nodes in the CPU cluster | `number` | `0` | no |
| <a name="input_cpu_vm_size"></a> [cpu\_vm\_size](#input\_cpu\_vm\_size) | The VM size for the CPU cluster | `string` | `"Standard_DS3_v2"` | no |
| <a name="input_idle_seconds_before_scaledown"></a> [idle\_seconds\_before\_scaledown](#input\_idle\_seconds\_before\_scaledown) | The number of seconds of idle time before a node is considered for scaledown | `number` | `900` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where resources will be created | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The ID of the subnet for compute clusters | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cpu_cluster_id"></a> [cpu\_cluster\_id](#output\_cpu\_cluster\_id) | The ID of the CPU compute cluster |
| <a name="output_cpu_cluster_name"></a> [cpu\_cluster\_name](#output\_cpu\_cluster\_name) | The name of the CPU compute cluster |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
