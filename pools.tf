locals {
  pools = [
    {
      name = "test_pool1"
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
    {
      name = "test_pool2"
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
    {
      name = "test_pool3"
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
  ]
}

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

module "sonar"{
  source = "./sonar"
  for_each = local.pools.value
  check_type = "http"
  pool_name = each.key
  pool_values = each.value
}