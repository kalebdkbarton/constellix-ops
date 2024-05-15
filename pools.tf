locals {
  http_check_ids = { for idx, check in constellix_http_check.test_http_check_pools : idx => check.id }
  pools = {
    test_pool1 = {
      values = [
        {
          value        = "108.157.142.75"
          weight       = 20
          policy       = "followsonar"
          disable_flag = false
        },
        {
          value        = "108.157.142.25"
          weight       = 20
          policy       = "followsonar"
          disable_flag = false
        }
      ]
    },
    test_pool2 = {
      values = [
        {
          value        = "108.157.142.97"
          weight       = 20
          policy       = "followsonar"
          disable_flag = false
        },
        {
          value        = "108.157.142.56"
          weight       = 30
          policy       = "followsonar"
          disable_flag = false
        }
      ]
    },
    test_pool3 = {
      values = [
        {
          value        = "108.157.142.25"
          weight       = 20
          policy       = "followsonar"
          disable_flag = false
        },
        {
          value        = "108.157.142.56"
          weight       = 30
          policy       = "followsonar"
          disable_flag = false
        }
      ]
    }
  }
}

resource "constellix_a_record_pool" "test_pool" {
  for_each               = local.pools
  name                   = each.key
  num_return             = "1"
  min_available_failover = 1

  dynamic "values" {
    for_each = each.value.values
    content {
      value        = values.value.value
      weight       = values.value.weight
      policy       = values.value.policy
      disable_flag = values.value.disable_flag
      check_id     = local.http_check_ids["${each.key}_${values.key}"]
    }
  }

  failed_flag  = false
  disable_flag = false
  note         = local.name
}

resource "constellix_a_record" "test_a_pool" {
  for_each      = local.pools
  domain_id     = constellix_domain.kaleb.id
  source_type   = "domains"
  record_option = "roundRobin"
  ttl           = 100
  name          = each.key
  pools         = [for pool in constellix_a_record_pool.test_pool : pool.id]
  note          = local.name
}

resource "constellix_http_check" "test_http_check_pools" {
  count = length(flatten([for pool_name, pool in local.pools : [for value in pool.values : "${pool_name}_${value.value}"]]))

  name                = element(flatten([for pool_name, pool in local.pools : [for value in pool.values : "${pool_name}_${value.value}"]]), count.index)
  host                = element(flatten([for pool_name, pool in local.pools : [for value in pool.values : value.value]]), count.index)
  fqdn                = "resume.malavear.com"
  ip_version          = "IPV4"
  port                = 443
  protocol_type       = "HTTPS"
  check_sites         = [1, 2]
  interval            = "ONEMINUTE"
  interval_policy     = "ONCEPERSITE"
  verification_policy = "SIMPLE"
}
