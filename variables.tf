variable "location" {
  default = "East US"
}

variable "rg_name" {
  default = "rg-winvm-demo"
}

variable "vnet_name" {
  default = "vnet-win-demo"
}

variable "subnet_name" {
  default = "subnet-winvm"
}

variable "address_space" {
  default = ["10.0.0.0/16"]
}

variable "subnet_prefix" {
  default = ["10.0.1.0/24"]
}

variable "vm_name" {
  default = "winvm-demo01"
}

variable "vm_size" {
  default = "Standard_B2ms"
}

variable "admin_username" {
  default = "adminuser"
}

variable "admin_password" {
  sensitive = true
}


variable "admin_password" {
  type      = string
  sensitive = true
}
