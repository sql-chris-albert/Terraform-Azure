variable "db_name" {
  type        = string
  description = "The name of the database to create."
}

variable "server_id" {
  type        = string
  description = "The id of the server to create the database in."
}

variable "tag_environment" {
  type        = string
  description = "The object id of the admin account."
}