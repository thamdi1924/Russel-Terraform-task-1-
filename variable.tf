variable "environment" {
  default = "company-test"
}

variable "location" {
  default = "centralus"
}

variable "address_space" {
  default = ["10.2.0.0/16"]
}

variable "dotnet-subnet" {
  default = ["10.2.0.0/24"]
}

variable "js-subnet" {
  default = ["10.2.1.0/24"]
}

variable "sql-subnet" {
  default = ["10.2.2.0/24"]
}


variable "vmpassword" {}
