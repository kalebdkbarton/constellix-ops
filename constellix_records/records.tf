resource "constellix_a_record" "test_a" {
  for_each      = var.records.a
  domain_id     = constellix_domain.domain.id
  source_type   = "domains"
  record_option = "roundRobin"
  ttl           = 100
  name          = each.key == "root" ? "" : each.key
  roundrobin {
    value        = each.value
    disable_flag = "false"
  }
  note = var.name
}

resource "constellix_aaaa_record" "firstrecord" {
  for_each      = var.records.aaaa
  domain_id     = constellix_domain.kaleb.id
  source_type   = "domains"
  record_option = "roundRobin"
  ttl           = 100
  name          = each.key
  type          = "AAAA"
  gtd_region    = 1
  roundrobin {
    value        = each.value
    disable_flag = "false"
  }
  note = var.name
}

resource "constellix_cname_record" "firstrecord" {
  for_each      = var.records.cname
  domain_id     = constellix_domain.kaleb.id
  source_type   = "domains"
  record_option = "roundRobin"
  ttl           = 100
  name          = each.key
  host          = each.value
  type          = "CNAME"
  note          = var.name
}