resource "constellix_domain" "kaleb" {
  name = "kalebbarton-test.com"
  soa = {
    primary_nameserver = "ns41.constellix.com."
    ttl                = 1800
    refresh            = 48100
    retry              = 7200
    expire             = 1209
    negcache           = 8000
  }
}

resource "constellix_a_record" "test_failover" {
  for_each      = local.default_record.a
  domain_id     = constellix_domain.kaleb.id
  source_type   = "domains"
  record_option = "roundRobin"
  ttl           = 100
  name          = "${each.key}"
  geo_location = {
    geo_ip_user_region = 1
    drop               = "false"
  }
  roundrobin {
    value        = "${each.value}"
    disable_flag = "false"
  }
  note = "${local.name}"
}