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
  count                  = length(local.pools)

  name                   = local.pools[count.index].name
  num_return             = "10"
  min_available_failover = 1

  dynamic "values" {
    for_each = local.pools[count.index].pool_values
    content {
      value        = pool_values.value.value
      weight       = pool_values.value.weight
      policy       = pool_values.value.policy
      disable_flag = pool_values.value.disable_flag
    }
  }

  failed_flag  = false
  disable_flag = false
  note         = "First record"
}
