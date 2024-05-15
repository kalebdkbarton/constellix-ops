variable "records" {
  description = "Map of records to have created in Constellix"
  type        = map(any)
}

variable "pools" {
  description = "Map of pools created in Constellix"
  type        = map(any)
}

variable "note" {
  description = "Note to add to records"
  type        = string
}

variable "domain_id" {
  description = "ID of the Constellix Domain to have resources created in"
  type        = string
}