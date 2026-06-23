variable "app_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "mandatory_tags" {
  type = object({
    environment_type    = string
    department          = string
    owner_email         = string
    tool                = string
    terraform           = string
    app                 = string
    change_notification = string
    maintenance_window  = string
    criticality         = string
    data_classification = string
  })
}

variable "optional_tags" {
  type    = map(string)
  default = {}
}

variable "custom_tags" {
  type    = map(string)
  default = {}
}

variable "vnet_address_space" {
  type = string
}

variable "pe_subnet_prefix" {
  type = string
}

variable "dns_servers" {
  type    = list(string)
  default = []
}

variable "account_replication_type" {
  type    = string
  default = "GRS"
}

variable "is_hns_enabled" {
  type    = bool
  default = false
}

variable "blob_retention_days" {
  type    = number
  default = 30
}

variable "container_retention_days" {
  type    = number
  default = 30
}

variable "notes" {
  type    = string
  default = ""
}

variable "cors_rules" {
  type = list(object({
    allowed_headers    = optional(list(string))
    allowed_methods    = optional(list(string))
    allowed_origins    = optional(list(string))
    exposed_headers    = optional(list(string))
    max_age_in_seconds = optional(number)
  }))
  default = []
}