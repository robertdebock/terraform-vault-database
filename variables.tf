variable "db_hostname" {
  description = "The hostname to connect to."
  type        = string
  default     = "localhost"
}

variable "db_username" {
  description = "The username to use to connect to the database."
  type        = string
}
variable "db_password" {
  description = "The password to use to connect to the database."
  type        = string
}

variable "db_tcp_port" {
  description = "The TCP port to use to connect to postgres."
  type        = number
  default     = 5432
  validation {
    condition     = var.db_tcp_port > 0 && var.db_tcp_port < 65536
    error_message = "Please choose a valid TCP port between 1 and 65535."
  }
}
