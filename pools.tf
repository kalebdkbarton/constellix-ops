resource "constellix_a_record_pool" "test_pool" {
  count = length(local.pools)

  name                   = local.pools[count.index].name
  num_return             = "1"
  min_available_failover = 1

  dynamic "values" {
    for_each = local.pools[count.index].values
    content {
      value        = values.value.value
      weight       = values.value.weight
      policy       = values.value.policy
      disable_flag = values.value.disable_flag
      check_id     = resource.constellix_http_check.test_http_check[local.pools[count.index].name].id
    }
  }

  failed_flag  = false
  disable_flag = false
  note         = local.name
}

resource "constellix_a_record" "test_a_pool" {
  count         = length(local.pools)
  domain_id     = constellix_domain.kaleb.id
  source_type   = "domains"
  record_option = "roundRobin"
  ttl           = 100
  name          = local.pools[count.index].name
  pools         = [for pool in constellix_a_record_pool.test_pool : pool.id]
  note          = local.name
}

resource "constellix_http_check" "test_http_check" {
  for_each = {
    for pool in local.pools : "${pool.name}" => toset(flatten([for value in pool.values : value.value]))
  }

  name                = "malavear-check-${each.key}"
  host                = join(",", each.value)
  fqdn                = "resume.malavear.com"
  ip_version          = "IPV4"
  port                = 443
  protocol_type       = "HTTPS"
  check_sites         = [1, 2]
  interval            = "ONEMINUTE"
  interval_policy     = "ONCEPERSITE"
  verification_policy = "SIMPLE"
}
