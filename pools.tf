locals {
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
  for_each = local.pools
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
      #check_id     = resource.constellix_http_check.test_http_check[each.name].id
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
  name          = local.pools[count.index].name
  pools         = [for pool in constellix_a_record_pool.test_pool : pool.id]
  note          = local.name
}

# resource "constellix_http_check" "test_http_check_pools" {
#   for_each = var.pool_values.value

#   name                = "${var.pool_name}-${each.value.value}"
#   host                = each.value.value
#   fqdn                = "resume.malavear.com"
#   ip_version          = "IPV4"
#   port                = 443
#   protocol_type       = "HTTPS"
#   check_sites         = [1, 2]
#   interval            = "ONEMINUTE"
#   interval_policy     = "ONCEPERSITE"
#   verification_policy = "SIMPLE"
# }
