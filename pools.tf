locals {
  flattened_pool_ips = {
    for pool_name, pool in local.pools : 
    pool_name => distinct([for value in pool.values : value.value])
  }
  fully_flattened_pool_ips = merge([
    for pool_name, ip_addresses in local.flattened_pool_ips : {
      for ip_address in ip_addresses : 
      "${pool_name}_${ip_address}" => ip_address
    }
  ])

 pools = {
    test_pool1 = {
      values = [
        {
          value        = "108.157.142.75"
          weight       = 20
          policy       = "followsonar"
          disable_flag = false
          fqdn = "resume.malavear.com"
        },
        {
          value        = "108.157.142.25"
          weight       = 20
          policy       = "followsonar"
          disable_flag = false
          fqdn = "resume.malavear.com" 
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
          fqdn = "resume.malavear.com"
        },
        {
          value        = "108.157.142.56"
          weight       = 30
          policy       = "followsonar"
          disable_flag = false
          fqdn = "resume.malavear.com"
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
          fqdn = "resume.malavear.com"
        },
        {
          value        = "108.157.142.56"
          weight       = 30
          policy       = "followsonar"
          disable_flag = false
          fqdn = "resume.malavear.com"
        }
      ]
    }
  }
}

resource "constellix_http_check" "test_http_check_pools" {
  for_each = fully_flattened_pool_ips

  name                = each.key
  host                = each.value
  fqdn                = "resume.malavear.com"
  ip_version          = "IPV4"
  port                = 443
  protocol_type       = "HTTPS"
  check_sites         = [1, 2]
  interval            = "ONEMINUTE"
  interval_policy     = "ONCEPERSITE"
  verification_policy = "SIMPLE"
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
      #check_id     = 
    }
  }

  failed_flag  = false
  disable_flag = false
  note         = local.name
}

# resource "constellix_a_record" "test_a_pool" {
#   for_each      = local.pools
#   domain_id     = constellix_domain.kaleb.id
#   source_type   = "domains"
#   record_option = "roundRobin"
#   ttl           = 100
#   name          = each.key
#   pools         = [for pool in constellix_a_record_pool.test_pool : pool.id]
#   note          = local.name
# }