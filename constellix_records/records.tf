resource "constellix_a_record" "this" {
  for_each      = var.records.a
  domain_id     = var.domain_id
  source_type   = "domains"
  record_option = "roundRobin"
  ttl           = 100
  name          = each.key == "root" ? "" : each.key
  roundrobin {
    value        = each.value
    disable_flag = "false"
  }
  note = var.note
}

resource "constellix_aaaa_record" "this" {
  for_each      = var.records.aaaa
  domain_id     = var.domain_id
  source_type   = "domains"
  record_option = "roundRobin"
  ttl           = 100
  name          = each.key == "root" ? "" : each.key
  type          = "AAAA"
  gtd_region    = 1
  roundrobin {
    value        = each.value
    disable_flag = "false"
  }
  note = var.note
}

resource "constellix_cname_record" "this" {
  for_each      = var.records.cname
  domain_id     = var.domain_id
  source_type   = "domains"
  record_option = "roundRobin"
  ttl           = 100
  name          = each.key
  host          = each.value
  type          = "CNAME"
  note          = var.note
}