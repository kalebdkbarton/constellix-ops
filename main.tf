module "constellix_domain" {
  source    = "./constellix_domains"
  for_each  = toset(local.domains)
  domain    = each.key
}

module "constellix_records" {
  source    = "./constellix_records"
  for_each  = module.constellix_domain
  records   = local.records
  note      = local.note
  pools     = local.pools
  domain_id = each.value.domain_id
}