module "constellix_domain" {
  for_each = toset(local.domains)
  source = "./constellix_domains"
  apikey = var.apikey
  secretkey = var.secretkey
  domain = each.key
}

module "constellix_records" {
  source = "./constellix_records"
  apikey = var.apikey
  secretkey = var.secretkey
  records = toset(local.domains)
  name = local.name
}