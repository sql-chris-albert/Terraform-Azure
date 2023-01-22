# Networking
resource "azurerm_virtual_network" "vnet-terraform" {
  name                = "vnet-terraform"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg-terraform.location
  resource_group_name = azurerm_resource_group.rg-terraform.name
}

resource "azurerm_subnet" "subn-terraform" {
  name                 = "subn-terraform"
  resource_group_name  = azurerm_resource_group.rg-terraform.name
  virtual_network_name = azurerm_virtual_network.vnet-terraform.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_network_security_group" "nsg-terraform" {
  name                = "nsg-terraform"
  location            = azurerm_resource_group.rg-terraform.location
  resource_group_name = azurerm_resource_group.rg-terraform.name
}

resource "azurerm_subnet_network_security_group_association" "nsga" {
  subnet_id                 = azurerm_subnet.subn-terraform.id
  network_security_group_id = azurerm_network_security_group.nsg-terraform.id
}

resource "azurerm_public_ip" "pip-terraform" {
  name                = "pip-terraform"
  location            = azurerm_resource_group.rg-terraform.location
  resource_group_name = azurerm_resource_group.rg-terraform.name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_security_rule" "RDPRule" {
  name                        = "RDPRule"
  resource_group_name         = azurerm_resource_group.rg-terraform.name
  priority                    = 1000
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = 3389
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name = azurerm_network_security_group.nsg-terraform.name
}

resource "azurerm_network_security_rule" "MSSQLRule" {
  name                        = "MSSQLRule"
  resource_group_name         = azurerm_resource_group.rg-terraform.name
  priority                    = 1001
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = 1433
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name = azurerm_network_security_group.nsg-terraform.name
}

resource "azurerm_network_interface" "nic-terraform" {
  name                = "nic-terraform"
  location            = azurerm_resource_group.rg-terraform.location
  resource_group_name = azurerm_resource_group.rg-terraform.name

  ip_configuration {
    name                          = "exampleconfiguration1"
    subnet_id                     = azurerm_subnet.subn-terraform.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip-terraform.id
  }
}

resource "azurerm_network_interface_security_group_association" "nicsga-terraform" {
  network_interface_id      = azurerm_network_interface.nic-terraform.id
  network_security_group_id = azurerm_network_security_group.nsg-terraform.id
}