resource "constellix_domain" "domain" {
  for_each = toset(local.domains)

  name = each.key
  soa = {
    primary_nameserver = "ns41.constellix.com."
    ttl                = 1800
    refresh            = 48100
    retry              = 7200
    expire             = 1209
    negcache           = 8000
  }
}
