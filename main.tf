# resource "vault_database_secrets_mount" "default" {
#   path = "database"
#   postgresql {
#     name              = "postgres"
#     username          = var.db_username
#     password          = var.db_password
#     connection_url    = "postgresql://{{username}}:{{password}}@${var.db_hostname}:${var.db_tcp_port}/postgres"
#     verify_connection = true
#     allowed_roles     = ["postgres-dev"]
#   }
# }

resource "vault_mount" "default" {
  path = "postgres"
  type = "database"
}

# resource "vault_database_secret_backend_role" "default" {
#   name    = "postgres-dev"
#   backend = vault_database_secrets_mount.default.path
#   db_name = vault_database_secrets_mount.default.postgresql[0].name
#   creation_statements = [
#     "CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}';",
#     "GRANT SELECT ON ALL TABLES IN SCHEMA public TO \"{{name}}\";",
#   ]
# }

resource "vault_database_secret_backend_connection" "default" {
  backend       = vault_mount.default.path
  name          = "postgres"
  allowed_roles = ["dev", "prod"]

  postgresql {
    connection_url = "postgres://username:password@host:port/database"
  }
}
resource "vault_generic_endpoint" "rotate_initial_db_password" {
  depends_on     = [vault_database_secret_backend_connection.default]
  path           = "database/rotate-root/${vault_database_secret_backend_connection.default.name}"
  disable_read   = true
  disable_delete = true
  data_json      = "{}"
}
