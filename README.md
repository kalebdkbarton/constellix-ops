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
| [constellix_a_record.test_failover](https://registry.terraform.io/providers/Constellix/constellix/latest/docs/resources/a_record) | resource |
| [constellix_domain.kaleb](https://registry.terraform.io/providers/Constellix/constellix/latest/docs/resources/domain) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apikey"></a> [apikey](#input\_apikey) | constellix api key | `string` | `""` | no |
| <a name="input_secretkey"></a> [secretkey](#input\_secretkey) | constellix api key | `string` | `""` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->