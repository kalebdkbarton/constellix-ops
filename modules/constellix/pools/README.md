<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_constellix"></a> [constellix](#requirement\_constellix) | >= 0.4.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_constellix"></a> [constellix](#provider\_constellix) | >= 0.4.5 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [constellix_a_record_pool.this](https://registry.terraform.io/providers/Constellix/constellix/latest/docs/resources/a_record_pool) | resource |
| [constellix_http_check.this](https://registry.terraform.io/providers/Constellix/constellix/latest/docs/resources/http_check) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_note"></a> [note](#input\_note) | Note to add to records | `string` | n/a | yes |
| <a name="input_pools"></a> [pools](#input\_pools) | Map of pools to have created in Constellix | `map(any)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_pool_info"></a> [pool\_info](#output\_pool\_info) | n/a |
<!-- END_TF_DOCS -->