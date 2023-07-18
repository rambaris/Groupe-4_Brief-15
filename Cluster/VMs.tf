resource "azurerm_resource_group" "Kubernetes" {
   name = "Groupe4-Brief15-RG"
   location = var.location
}

# Create (and display) an SSH key
resource "tls_private_key" "SSH" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
#### 2 Workers VM
 resource "azurerm_linux_virtual_machine" "test" {
    count                 = 2
    name                  = "worker${count.index}"
    location              = azurerm_resource_group.Kubernetes.location
    resource_group_name   = azurerm_resource_group.Kubernetes.name
    size                  = "Standard_D2ds_v4"
    network_interface_ids = [
     azurerm_network_interface.test["${count.index}"].id
    ]

    source_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "8_5-gen2"
    version   = "latest"
  }

    computer_name                   = "worker-${count.index}"
    admin_username                  = "group4"
    disable_password_authentication = true

    admin_ssh_key {
      username   = "group4"
      public_key = tls_private_key.SSH.public_key_openssh
   }

    os_disk {
      name = "OSdisk${count.index}"
      caching = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }
}

 resource "azurerm_linux_virtual_machine" "Manager" {
    name                  = "manager"
    location              = azurerm_resource_group.Kubernetes.location
    resource_group_name   = azurerm_resource_group.Kubernetes.name
    size                  = "Standard_D2ds_v4"
    network_interface_ids = [
     azurerm_network_interface.test["${2}"].id
     ]

    source_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "8_5-gen2"
    version   = "latest"
  }

    computer_name                   = "manager"
    admin_username                  = "group4"
    disable_password_authentication = true

    admin_ssh_key {
     username   = "group4"
     public_key = tls_private_key.SSH.public_key_openssh
    }

    os_disk {
      name = "OSdisk"
      caching = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }

      provisioner "file" {
        source = "./Main/2048_deployment_replicated.yaml"
        destination = "/home/group4/2048_deployment_replicated.yaml"
     }

    depends_on = [azurerm_resource_group.Kubernetes]
}
