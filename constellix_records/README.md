# constellix-ops
Testing the constellix terraform repo

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
| [constellix_a_record.test_a](https://registry.terraform.io/providers/Constellix/constellix/latest/docs/resources/a_record) | resource |
| [constellix_a_record_pool.firstrecord](https://registry.terraform.io/providers/Constellix/constellix/latest/docs/resources/a_record_pool) | resource |
| [constellix_a_record_pool.test_pool](https://registry.terraform.io/providers/Constellix/constellix/latest/docs/resources/a_record_pool) | resource |
| [constellix_aaaa_record.firstrecord](https://registry.terraform.io/providers/Constellix/constellix/latest/docs/resources/aaaa_record) | resource |
| [constellix_cname_record.firstrecord](https://registry.terraform.io/providers/Constellix/constellix/latest/docs/resources/cname_record) | resource |
| [constellix_http_check.test_http_check_pools](https://registry.terraform.io/providers/Constellix/constellix/latest/docs/resources/http_check) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain_id"></a> [domain\_id](#input\_domain\_id) | ID of the Constellix Domain to have resources created in | `string` | n/a | yes |
| <a name="input_note"></a> [note](#input\_note) | Note to add to records | `string` | n/a | yes |
| <a name="input_pools"></a> [pools](#input\_pools) | Map of pools to have created in Constellix | `map(any)` | n/a | yes |
| <a name="input_records"></a> [records](#input\_records) | Map of records to have created in Constellix | `map(any)` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->