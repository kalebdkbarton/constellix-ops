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

resource "constellix_aname_record" "this" {
  for_each      = var.records.aname
  domain_id     = var.domain_id
  source_type   = "domains"
  record_option = "roundRobin"
  ttl           = 100
  name          = each.key == "root" ? "" : each.key
  type          = "ANAME"
  roundrobin {
    value        = each.value
  }
  note          = var.note
}

resource "constellix_ns_record" "this" {
  for_each      = var.records.ns
  domain_id     = var.domain_id
  source_type   = "domains"
  ttl           = 100
  name          = each.key == "root" ? "" : each.key
  roundrobin {
    value        = each.value
  }
  type          = "NS"
  note          = var.note
}

resource "constellix_txt_record" "this" {
  for_each      = var.records.txt
  domain_id     = var.domain_id
  source_type   = "domains"
  ttl           = 100
  name          = each.key == "root" ? "" : each.key
  roundrobin {
    value        = each.value
  }
  type          = "TXT"
  note          = var.note
}

resource "constellix_spf_record" "this" {
  for_each      = var.records.spf
  domain_id     = var.domain_id
  source_type   = "domains"
  ttl           = 100
  name          = each.key == "root" ? "" : each.key
  roundrobin {
    value        = each.value
  }
  type          = "SPF"
  note          = var.note
}

resource "constellix_srv_record" "this" {
  for_each      = var.records.srv
  domain_id   = var.domain_id
  ttl         = 1800
  name        = each.key == "root" ? "" : each.key
  type        = "SRV"
  source_type = "domains"
  roundrobin {
    value        = split(",",each.value)[0]
    port         = split(",",each.value)[1]
    priority     = split(",",each.value)[2]
    weight       = split(",",each.value)[3]
  }
}

resource "constellix_a_record" "this_pool" {
  for_each      = var.pools
  domain_id     = var.domain_id
  source_type   = "domains"
  record_option = "roundRobin"
  ttl           = 100
  name          = each.key
  pools         = [each.value.pool_id]
  note          = var.note
}
