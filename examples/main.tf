
module "storage-account" {
  source  = "app.terraform.io/DXE-POC/vm-module/azurerm"
  version = "0.3.0"
  resource_group_name = "rg-tfe-poc"
  storage_name  = "storage-accoun-test"
  vm_name = "vm-test"
  rg_name = "rg-tfe-poc"
}