# Commented out due to bug
# resource "constellix_a_record" "this_pool" {
#   for_each      = var.a_pools
#   domain_id     = var.domain_id
#   source_type   = "domains"
#   record_option = "roundRobin"
#   ttl           = 100
#   name          = each.key
#   pools         = [each.value.pool_id]
#   note          = var.note
# }

# resource "constellix_cnamea_record" "this_pool" {
#   for_each      = var.cname_pools
#   domain_id     = var.domain_id
#   source_type   = "domains"
#   record_option = "roundRobin"
#   ttl           = 100
#   name          = each.key
#   pools         = [each.value.pool_id]
#   note          = var.note
# }
