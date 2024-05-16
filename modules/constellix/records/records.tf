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

resource "constellix_aname_record" "this" {
  for_each      = var.records.aname
  domain_id     = var.domain_id
  source_type   = "domains"
  record_option = "roundRobin"
  ttl           = 100
  name          = each.key == "root" ? "" : each.key
  type          = "ANAME"
  roundrobin {
    value = each.value
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

resource "constellix_hinfo_record" "this" {
  for_each    = var.records.srv
  domain_id   = var.domain_id
  ttl         = 1800
  name        = each.key == "root" ? "" : each.key
  source_type = "domains"
  type        = "HINFO"
  roundrobin {
    cpu = split(",", each.value)[0]
    os  = split(",", each.value)[1]
  }
}

resource "constellix_http_redirection_record" "this" {
  for_each         = var.records.srv
  domain_id        = var.domain_id
  source_type      = "domains"
  name             = each.key == "root" ? "" : each.key
  ttl              = 1800
  redirect_type_id = 1
  url              = each.value
  type             = "HTTPRedirection"
}

resource "constellix_mx_record" "this" {
  for_each    = var.records.mx
  domain_id   = var.domain_id
  ttl         = 1800
  name        = each.key == "root" ? "" : each.key
  source_type = "domains"
  type        = "MX"
  roundrobin {
    level = split(",", each.value)[0]
    value = split(",", each.value)[1]
  }
}

resource "constellix_naptr_record" "this" {
  for_each    = var.records.naptr
  domain_id   = var.domain_id
  ttl         = 1800
  name        = each.key == "root" ? "" : each.key
  source_type = "domains"
  type        = "NAPTR"
  roundrobin {
    order              = split(",", each.value)[0]
    preference         = split(",", each.value)[1]
    flags              = split(",", each.value)[2]
    service            = split(",", each.value)[3]
    regular_expression = split(",", each.value)[4]
    replacement        = split(",", each.value)[5]
    disable_flag       = false
  }
}

resource "constellix_caa_record" "this" {
  for_each    = var.records.caa
  domain_id   = var.domain_id
  ttl         = 1800
  name        = each.key == "root" ? "" : each.key
  source_type = "domains"
  type        = "CAA"
  roundrobin {
    caa_provider_id = split(",", each.value)[0]
    tag             = split(",", each.value)[1]
    data            = split(",", each.value)[2]
    flag            = split(",", each.value)[3]
    disable_flag    = false
  }
}

resource "constellix_cert_record" "this" {
  for_each    = var.records.cert
  domain_id   = var.domain_id
  ttl         = 1800
  name        = each.key == "root" ? "" : each.key
  source_type = "domains"
  type        = "CERT"
  roundrobin {
    certificate_type = split(",", each.value)[0]
    key_tag          = split(",", each.value)[1]
    certificate      = split(",", each.value)[2]
    algorithm        = split(",", each.value)[3]
    disable_flag     = false
  }
}

resource "constellix_ptr_record" "this" {
  for_each    = var.records.ptr
  domain_id   = var.domain_id
  ttl         = 1800
  name        = each.key == "root" ? "" : each.key
  source_type = "domains"
  type        = "PTR"
  roundrobin {
    value        = each.value
    disable_flag = false
  }
}

resource "constellix_rp_record" "this" {
  for_each    = var.records.rp
  domain_id   = var.domain_id
  ttl         = 1800
  name        = each.key == "root" ? "" : each.key
  source_type = "domains"
  type        = "RP"
  roundrobin {
    mailbox      = split(",", each.value)[0]
    txt          = split(",", each.value)[1]
    disable_flag = false
  }
}

resource "constellix_spf_record" "this" {
  for_each    = var.records.spf
  domain_id   = var.domain_id
  source_type = "domains"
  ttl         = 100
  name        = each.key == "root" ? "" : each.key
  roundrobin {
    value = each.value
  }
  type = "SPF"
  note = var.note
}

resource "constellix_srv_record" "this" {
  for_each    = var.records.srv
  domain_id   = var.domain_id
  ttl         = 1800
  name        = each.key == "root" ? "" : each.key
  type        = "SRV"
  source_type = "domains"
  roundrobin {
    value    = split(",", each.value)[0]
    port     = split(",", each.value)[1]
    priority = split(",", each.value)[2]
    weight   = split(",", each.value)[3]
  }
}

resource "constellix_txt_record" "this" {
  for_each    = var.records.txt
  domain_id   = var.domain_id
  source_type = "domains"
  ttl         = 100
  name        = each.key == "root" ? "" : each.key
  roundrobin {
    value = each.value
  }
  type = "TXT"
  note = var.note
}
resource "constellix_ns_record" "this" {
  for_each    = var.records.ns
  domain_id   = var.domain_id
  source_type = "domains"
  ttl         = 100
  name        = each.key == "root" ? "" : each.key
  roundrobin {
    value = each.value
  }
  type = "NS"
  note = var.note
}