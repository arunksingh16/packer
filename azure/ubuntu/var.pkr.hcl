variable "client_secret" {
  type      = string
  default   = "xxxxxxx"
  sensitive = false
}

variable "client_id" {
  type      = string
  default   = "xxxxxxx"
  sensitive = false
}

variable "tenant_id" {
  type    = string
  default = "xxxxxxx"
}

variable "subscription_id" {
  type    = string
  default = "xxxxxxx"
}

variable "resource_grp" {
  type    = string
  default = "rg-packer"
}

variable "storage_accnt" {
  type    = string
  default = "stpacker"
}

variable "managed_image_name" {
  type    = string
  default = "packer"
}
