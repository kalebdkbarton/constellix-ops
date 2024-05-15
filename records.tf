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

resource "constellix_aaaa_record" "firstrecord" {
  for_each      = local.default_record.aaaa
  domain_id     = constellix_domain.kaleb.id
  source_type   = "domains"
  record_option = "roundRobin"
  ttl           = 100
  name          = each.key
  type        = "AAAA"
  gtd_region  = 1
  roundrobin {
    value        = each.value
    disable_flag = "false"
  }
  note = local.name
}

resource "constellix_cname_record" "firstrecord" {
  for_each      = local.default_record.cname
  domain_id     = constellix_domain.kaleb.id
  source_type   = "domains"
  record_option = "roundRobin"
  ttl           = 100
  name          = each.key
  host          = each.value
  type        = "CNAME"
  note = local.name
}