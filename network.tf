resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.environment}"
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.environment}"
  address_space       = var.address_space
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet-dotnet" {
  name                      = "subnet-dotnet"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.vnet.name
  address_prefixes          = var.dotnet-subnet
}

resource "azurerm_subnet" "subnet-js" {
  name                      = "subnet-js"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.vnet.name
  address_prefixes          = var.js-subnet
}

resource "azurerm_subnet" "subnet-sql" {
  name                      = "subnet-sql"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.vnet.name
  address_prefixes          = var.sql-subnet
}

resource "azurerm_network_interface" "nic-dotnet" {
  name                = "nic-dotnet-${var.environment}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  enable_ip_forwarding = true
  # enable_accelerated_networking = true

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet-dotnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.pip-dotnet.id
  }
}

resource "azurerm_network_interface" "nic-js" {
  name                = "nic-js-${var.environment}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  enable_ip_forwarding = true
  # enable_accelerated_networking = true

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet-js.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.pip-js.id
  }
}

resource "azurerm_network_interface" "nic-sql" {
  name                = "nic-sql-${var.environment}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  enable_ip_forwarding = true
  # enable_accelerated_networking = true
  
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet-sql.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.pip-sql.id

  }
}

resource "azurerm_public_ip" "pip-js" {
  name                = "Pip-Js-${var.environment}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"
}

resource "azurerm_public_ip" "pip-dotnet" {
  name                = "Pip-dotnet-${var.environment}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"
}

resource "azurerm_public_ip" "pip-sql" {
  name                = "Pip-sql-${var.environment}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"
}
