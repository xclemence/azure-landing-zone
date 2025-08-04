resource "azurerm_resource_group" "test" {
  name     = "poc-lz-test-01"
  location = var.location
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "azurerm_linux_virtual_machine" "test" {
  name                            = "slazxcetest01"
  resource_group_name             = azurerm_resource_group.test.name
  location                        = azurerm_resource_group.test.location
  size                            = "Standard_B2s"
  admin_username                  = "adminuser"
  admin_password                  = random_password.password.result
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.test.id,
  ]

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

resource "azurerm_dev_test_global_vm_shutdown_schedule" "example" {
  virtual_machine_id = azurerm_linux_virtual_machine.test.id
  location           = azurerm_resource_group.test.location
  enabled            = true

  daily_recurrence_time = "1900"
  timezone              = "Romance Standard Time"

  notification_settings {
    enabled = false
  }
}
