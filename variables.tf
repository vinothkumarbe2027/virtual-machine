variable "location" {
  type    = string
  default = "East US"
}

variable "rg_name" {
  type    = string
  default = "rg-winvm-demo"
}

variable "vnet_name" {
  type    = string
  default = "vnet-win-demo"
}

variable "subnet_name" {
  type    = string
  default = "subnet-winvm"
}

variable "address_space" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}

variable "subnet_prefix" {
  type    = list(string)
  default = ["10.0.1.0/24"]
}

variable "vm_name" {
  type    = string
  default = "winvm-demo01"
}

variable "vm_size" {
  type    = string
  default = "Standard_B2ms"
}

variable "admin_username" {
  type    = string
  default = "adminuser"
}

variable "admin_password" {
  type      = string
  sensitive = true
}
