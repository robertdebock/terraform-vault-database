resource "vault_database_secrets_mount" "default" {
  path = "database"
  postgresql {
    name              = "postgres"
    username          = var.db_username
    password          = var.db_password
    connection_url    = "postgresql://{{username}}:{{password}}@${var.db_hostname}:${var.db_tcp_port}/postgres"
    verify_connection = true
    allowed_roles     = ["postgres-dev"]
  }
  provisioner "local-exec" {
    command = "vault write --force ${self.path}/rotate-root/${self.postgresql[0].name}"
  }
}

resource "vault_database_secret_backend_role" "default" {
  name    = "postgres-dev"
  backend = vault_database_secrets_mount.default.path
  db_name = vault_database_secrets_mount.default.postgresql[0].name
  creation_statements = [
    "CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}';",
    "GRANT SELECT ON ALL TABLES IN SCHEMA public TO \"{{name}}\";",
  ]
}
