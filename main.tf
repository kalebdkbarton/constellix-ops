module "constellix_domain" {
  source = "./constellix_domains"
  for_each = local.domains
  apikey = var.apikey
  secretkey = var.secretkey
  domain = each.key
}

module "constellix_records" {
  source = "./constellix_records"
  count = module.constellix_domain
  apikey = var.apikey
  secretkey = var.secretkey
  records = toset(local.domains)
  name = local.name
  domain_id = module.constellix_domain[count.index]
}