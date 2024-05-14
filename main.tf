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

resource "constellix_a_record" "test_a" {
  for_each      = local.default_record.a
  domain_id     = constellix_domain.kaleb.id
  source_type   = "domains"
  record_option = "roundRobin"
  ttl           = 100
  name          = each.key
  roundrobin {
    value        = each.value
    disable_flag = "false"
  }
  note = local.name
}

resource "constellix_a_record_pool" "test_a_pool" {
  name                   = "firstrecord"
  num_return             = "10"
  min_available_failover = 1
  values {
    value        = "8.1.1.1"
    weight       = 20
    policy       = "followsonar"
    disable_flag = false
  }
  values {
    value        = "9.1.1.1"
    weight       = 20
    policy       = "followsonar"
    disable_flag = false
  }
  failed_flag  = false
  disable_flag = false
  note         = "First record"
}