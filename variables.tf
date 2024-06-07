variable "default_tags" {
  type        = map(any)
  description = "List of tags to be applied to the resources of this infrastructure"
  default = {
    team     = "dopt",
    owner    = "dopt",
    activity = "test-tfe-module",
  }
}

variable "storage_name" {
  type = string
  description = "Storage name"
}
variable "vm_name" {
  type = string
  description = "Virtual name"
}

variable "rg_name" {
  type = string
  description = "resource name"
}
variable "rg_loc" {
  type    = string
  description = "resource location"
  default = "westus2"
}