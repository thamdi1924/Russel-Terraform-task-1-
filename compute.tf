resource "azurerm_linux_virtual_machine" "vm-dotnet" {
  name                            = "vm-dotnet"
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  size                            = "Standard_B2s"
  admin_username                  = "adminuser"
  admin_password                  = var.vmpassword
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.nic-dotnet.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}

resource "azurerm_linux_virtual_machine" "vm-js" {
  name                            = "vm-js"
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  size                            = "Standard_B2s"
  admin_username                  = "adminuser"
  admin_password                  = var.vmpassword
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.nic-js.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }


  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}

resource "azurerm_linux_virtual_machine" "vm-sql" {
  name                            = "vm-sql"
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  size                            = "Standard_B2s"
  admin_username                  = "adminuser"
  admin_password                  = var.vmpassword
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.nic-sql.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}

resource "azurerm_virtual_machine_extension" "js-script" {
  name                 = "js-script"
  virtual_machine_id   = azurerm_linux_virtual_machine.vm-js.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"
  settings = <<SETTINGS
  {
    "commandToExecute": "sudo apt install npm -y && sudo apt install nodejs-legacy && sudo apt update && sudo apt upgrade -y && sudo npm -g install create-react-app"
    }
    SETTINGS

}

resource "azurerm_virtual_machine_extension" "sql-script" {
  name                 = "sql-script"
  virtual_machine_id   = azurerm_linux_virtual_machine.vm-sql.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"
  settings = <<SETTINGS
  {
    "commandToExecute": "sudo apt-get update && sudo apt-get install -y mssql-server"
    }
    SETTINGS
}

resource "azurerm_virtual_machine_extension" "dotnet-script" {
  name                 = "dotnet-script"
  virtual_machine_id   = azurerm_linux_virtual_machine.vm-dotnet.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"
  settings = <<SETTINGS
  {
    "commandToExecute": "sudo snap install dotnet-sdk --classic --channel=5.0"
    }
    SETTINGS
}
