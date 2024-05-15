resource "constellix_http_check" "test_http_check_pools" {
  for_each = var.pool_values.value

  name                = "${var.pool_name}-${each.value.value}"
  host                = each.value.value
  fqdn                = "resume.malavear.com"
  ip_version          = "IPV4"
  port                = 443
  protocol_type       = "HTTPS"
  check_sites         = [1, 2]
  interval            = "ONEMINUTE"
  interval_policy     = "ONCEPERSITE"
  verification_policy = "SIMPLE"
}
