module "constellix_domain" {
  source = "./constellix_domains"
  for_each = toset(local.domains)
  apikey = var.apikey
  secretkey = var.secretkey
  domain = each.key
}

module "constellix_records" {
  source     = "./constellix_records"
  for_each   = module.constellix_domain
  apikey     = var.apikey
  secretkey  = var.secretkey
  records    = local.records
  name       = local.name
  domain_id  = each.value.domain_id
}