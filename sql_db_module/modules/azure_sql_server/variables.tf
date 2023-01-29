variable "server_name" {
  type        = string
  description = "The name of the server to create."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group to create the server in."
}

variable "azure_region" {
  type        = string
  description = "The Azure region to deploy infrastructure."
}

variable "admin_username" {
  type        = string
  description = "The username of the admin account."
}

variable "admin_object_id" {
  type        = string
  description = "The object id of the admin account."
}

variable "tag_environment" {
  type        = string
  description = "The object id of the admin account."
}