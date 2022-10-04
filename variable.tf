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
  default = ["10.2.0.0/27"]
}

variable "js-subnet" {
  default = ["10.2.0.32/27"]
}

variable "sql-subnet" {
  default = ["10.2.0.64/27"]
}


variable "vmpassword" {}