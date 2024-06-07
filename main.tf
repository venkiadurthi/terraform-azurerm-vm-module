resource "azurerm_storage_account" "example" {
  name                     = var.storage_name
  resource_group_name      = var.rg_name
  location                 = var.rg_loc
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = var.default_tags
}


resource "azurerm_virtual_network" "example" {
  name                = join("-", "${var.vm_name}", "network")
  address_space       = ["10.1.0.0/16"]
  location            = var.rg_loc
  resource_group_name = var.rg_name
}

resource "azurerm_subnet" "example" {
  name                 = "internal"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.1.2.0/24"]
}

resource "azurerm_network_interface" "example" {
  name                = join("-", "${var.vm_name}", "nic")
  resource_group_name = var.rg_name
  location            = var.rg_loc

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_linux_virtual_machine" "example" {
  name                = var.vm_name
  resource_group_name = var.rg_name
  location            = var.rg_loc
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.example.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}