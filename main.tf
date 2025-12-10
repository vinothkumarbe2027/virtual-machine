provider "azurerm" {
  features {}
}

# ----------------------
# RESOURCE GROUP
# ----------------------
data "azurerm_resource_group" "rg" {
  name     = var.rg_name
  #location = var.location
}

# ----------------------
# VIRTUAL NETWORK
# ----------------------
resource "azurerm_virtual_network" "vnet" {
  depends_on = [azurerm_resource_group.rg]

  name                = var.vnet_name
  address_space       = var.address_space
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.location
}

# ----------------------
# SUBNET
# ----------------------
resource "azurerm_subnet" "subnet" {
  depends_on = [azurerm_virtual_network.vnet]

  name                 = var.subnet_name
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_prefix
}

# ----------------------
# PUBLIC IP
# ----------------------
resource "azurerm_public_ip" "pip" {
  depends_on = [azurerm_resource_group.rg]

  name                = "${var.vm_name}-pip"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

# ----------------------
# NETWORK INTERFACE
# ----------------------
resource "azurerm_network_interface" "nic" {
  depends_on = [
    azurerm_public_ip.pip,
    azurerm_subnet.subnet
  ]

  name                = "${var.vm_name}-nic"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.location

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}

# ----------------------
# WINDOWS VM
# ----------------------
resource "azurerm_windows_virtual_machine" "vm" {
  depends_on = [azurerm_network_interface.nic]

  name                = var.vm_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.location
  size                = var.vm_size

  admin_username = var.admin_username
  admin_password = var.admin_password

  network_interface_ids = [azurerm_network_interface.nic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter"
    version   = "latest"
  }
}





