resource "constellix_a_record_pool" "firstrecord" {
  name                   = "firstrecord"
  num_return             = 1
  min_available_failover = 1
  values {
    value        = "8.1.1.1"
    weight       = 20
    policy       = "alwayson"
    disable_flag = false
  }
  failed_flag  = false
  disable_flag = false
  note         = "First record"
}

resource "constellix_a_record" "test_a_pool" {
  domain_id     = var.domain_id
  source_type   = "domains"
  record_option = "roundRobin"
  ttl           = 100
  name          = "firstrecord"
  pools         = [constellix_a_record_pool.firstrecord.id]
  note          = var.name
}