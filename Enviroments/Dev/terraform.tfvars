# Resource Groups

rg_name = {
  rg1 = {
    name       = "dev_rg_01"
    location   = "westus"
    managed_by = "Terraform"
    tags = {
      env        = "dev"
      team       = "dev-007"
      created_by = "Dinesh"
    }
  }
}

# Virtual Networks

vnet_name = {
  vnet1 = {
    name                = "dev-vnet-01"
    location            = "westus"
    resource_group_name = "dev_rg_01"
    address_space       = ["10.0.0.0/16"]
    tags = {
      env = "dev"
    }
  }
}

# Subnets

subnets = {
  subnet1 = {
    subnet_name          = "subnet-01"
    resource_group_name  = "dev_rg_01"
    virtual_network_name = "dev-vnet-01"
    address_prefixes     = ["10.0.1.0/24"]
  }

  subnet2 = {
    subnet_name          = "subnet-02"
    resource_group_name  = "dev_rg_01"
    virtual_network_name = "dev-vnet-01"
    address_prefixes     = ["10.0.2.0/24"]
  }

  subnet3 = {
    subnet_name          = "AzureBastionSubnet"
    resource_group_name  = "dev_rg_01"
    virtual_network_name = "dev-vnet-01"
    address_prefixes     = ["10.0.3.0/24"]
  }
}

# Public IP Addresses

public_ip = {
  "bastion_pip" = {
    pip_name            = "dev-pip-01"
    resource_group_name = "dev_rg_01"
    location            = "westus"
    allocation_method   = "Static"
    tags = {
      env = "dev"
      app = "bastion"
    }
  }
}

# Network Security Groups

nsgs = {
  nsg1 = {
    nsg_name            = "devnsg01"
    location            = "westus"
    resource_group_name = "dev_rg_01"

    security_rule = [
      {
        name                       = "SSH_Rule"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        description                = "Allow ssh port"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]

    tags = {
      env = "dev"
    }
  }

  nsg2 = {
    nsg_name            = "devnsg02"
    location            = "westus"
    resource_group_name = "dev_rg_01"

    security_rule = [
      {
        name                       = "SSH_Rule"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        description                = "Allow ssh port"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
    ]
  }
}

# Network Interface 

nics = {
  nic1 = {
    name                 = "dev-nic-01"
    location             = "westus"
    resource_group_name  = "dev_rg_01"
    virtual_network_name = "dev-vnet-01"
    subnet_name          = "subnet-01"
    ip_configuration = {
      ipconfig1 = {
        name                          = "ipconfig1"
        private_ip_address_allocation = "Dynamic"
      }
    }
  }

  nic2 = {
    name                 = "dev-nic-02"
    location             = "westus"
    resource_group_name  = "dev_rg_01"
    virtual_network_name = "dev-vnet-01"
    subnet_name          = "subnet-02"
    ip_configuration = {
      ipconfig2 = {
        name                          = "ipconfig2"
        private_ip_address_allocation = "Dynamic"
      }
    }
  }
}

# Subnets and NSGs Association

subnet_nsg_nic_assoc = {
  sub_nsg_assoc1 = {
    nsg_name             = "devnsg01"
    virtual_network_name = "dev-vnet-01"
    subnet_name          = "subnet-01"
    resource_group_name  = "dev_rg_01"
    nic_name             = "dev-nic-01"
  }

  sub_nsg_assoc2 = {
    nsg_name             = "devnsg02"
    virtual_network_name = "dev-vnet-01"
    subnet_name          = "subnet-02"
    resource_group_name  = "dev_rg_01"
    nic_name             = "dev-nic-02"
  }
}

# Bastion Host

bastion_hosts = {
  bastion1 = {
    bastion_host_name         = "dev-bastion-host"
    resource_group_name       = "dev_rg_01"
    location                  = "westus"
    sku                       = "Standard"
    virtual_network_name      = "dev-vnet-01"
    subnet_name               = "AzureBastionSubnet"
    pip_name                  = "dev-pip-01"
    copy_paste_enabled        = true
    file_copy_enabled         = true
    ip_connect_enabled        = true
    kerberos_enabled          = false
    scale_units               = 3
    shareable_link_enabled    = true
    tunneling_enabled         = true
    session_recording_enabled = false

    ip_configuration = {
      name = "bastion-ipconfig"
    }

    tags = {
      environment = "dev"
      project     = "bastion-dev"
    }
  }
}

# Key Vault and Key Vault Secrets

key_vaults = {
  kv1 = {
    key_vault_name              = "devnewkv01"
    location                    = "westus"
    resource_group_name         = "dev_rg_01"
    enabled_for_disk_encryption = true
    soft_delete_retention_days  = 7
    purge_protection_enabled    = true
    sku_name                    = "standard"

    access_policy = {
      key_permissions     = ["Get", "Create"]
      secret_permissions  = ["Get", "List", "Set", "Delete", "Purge", "Recover"]
      storage_permissions = ["Get", "List", "Set"]
    }
  }
}

key_vault_secrets = {
  vm_users = {
    secret_name         = "vm-username"
    secret_value        = "adminuser"
    key_vault_name      = "devnewkv01"
    resource_group_name = "dev_rg_01"
  }

  vm_pass = {
    secret_name         = "vm-password"
    secret_value        = "Bbpl@#123456"
    key_vault_name      = "devnewkv01"
    resource_group_name = "dev_rg_01"
  }

  sql_user = {
    secret_name         = "db-username"
    secret_value        = "dbuser"
    key_vault_name      = "devnewkv01"
    resource_group_name = "dev_rg_01"
  }

  sql_pass = {
    secret_name         = "db-password"
    secret_value        = "Bbpl@#123456"
    key_vault_name      = "devnewkv01"
    resource_group_name = "dev_rg_01"
  }

}

# Virtual Machines

vms = {
  vm1 = {
    vm_name                         = "frontend-vm-01"
    location                        = "westus"
    resource_group_name             = "dev_rg_01"
    size                            = "Standard_B2s"
    nic_name                        = "dev-nic-01"
    key_vault_name                  = "devnewkv01"
    secret_name                     = "vm-username"
    secret_password                 = "vm-password"
    disable_password_authentication = false

    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }

    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts-gen2"
      version   = "latest"
    }
  }

  vm2 = {
    vm_name                         = "backend-vm-01"
    location                        = "westus"
    resource_group_name             = "dev_rg_01"
    size                            = "Standard_B2s"
    nic_name                        = "dev-nic-02"
    key_vault_name                  = "devnewkv01"
    secret_name                     = "vm-username"
    secret_password                 = "vm-password"
    disable_password_authentication = false

    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }

    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts-gen2"
      version   = "latest"
    }
  }
}

storage_accounts = {
  "stg1" = {
    name                     = "newstorageaccount011"
    resource_group_name      = "dev_rg_01"
    location                 = "westus"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    access_tier              = "Hot"
  }
}

sql_servers = {
  "server1" = {
    name                          = "devnewsqlserver99"
    resource_group_name           = "dev_rg_01"
    location                      = "westus"
    version                       = "12.0"
    secret_name                   = "db-username"
    secret_password               = "db-password"
    key_vault_name                = "devnewkv01"
    connection_policy             = "Default"
    minimum_tls_version           = "1.2"
    public_network_access_enabled = true
    tags                          = { Environment = "Dev" }
  }
}

sql_databases = {
  "db1" = {
    db_name             = "devdb-01"
    sql_server_name     = "devnewsqlserver99"
    resource_group_name = "dev_rg_01"
    sku_name            = "GP_Gen5_2"
    max_size_gb         = 5
    short_term_retention_policy = {
      retention_days = 7
    }
    threat_detection_policy = {
      state                = "Enabled"
      email_account_admins = "Enabled"
      retention_days       = 30
    }
  }
}






























