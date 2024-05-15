module "constellix_domain" {
  source   = "./constellix_domains"
  for_each = toset(local.domains)
  domain   = each.key
}

module "constellix_pools" {
  source    = "./constellix_pools"
  note      = local.note
  pools     = local.pools
}

module "constellix_records" {
  source    = "./constellix_records"
  for_each  = module.constellix_domain
  records   = local.records
  note      = local.note
  pools     = module.constellix_pools.pool_info
  domain_id = each.value.domain_id
}