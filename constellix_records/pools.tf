locals {
  flattened_values = flatten([
    for pool_name, pool in var.pools : [
      for value in pool.values : {
        pool_name    = pool_name
        value        = value.value
        fqdn         = value.fqdn
        weight       = value.weight
        policy       = value.policy
        disable_flag = value.disable_flag
      }
    ]
  ])
}

resource "constellix_http_check" "test_http_check_pools" {
  for_each = { for value in local.flattened_values : "${value.pool_name}_${value.value}" => value }

  name                = each.value.pool_name
  host                = each.value.value
  fqdn                = each.value.fqdn
  ip_version          = "IPV4"
  port                = 443
  protocol_type       = "HTTPS"
  check_sites         = [1, 2]
  interval            = "ONEMINUTE"
  interval_policy     = "ONCEPERSITE"
  verification_policy = "SIMPLE"
}


resource "constellix_a_record_pool" "test_pool" {
  for_each               = var.pools
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
      check_id     = resource.constellix_http_check.test_http_check_pools["${each.key}_${values.value.value}"].id
    }
  }

  failed_flag  = false
  disable_flag = false
  note         = var.note
}

# resource "constellix_a_record" "test_a_pool" {
#   for_each      = local.pools
#   domain_id     = var.domain_id
#   source_type   = "domains"
#   record_option = "roundRobin"
#   ttl           = 100
#   name          = each.key
#   pools         = [for pool in constellix_a_record_pool.test_pool : pool.id]
#   note          = local.name
# }