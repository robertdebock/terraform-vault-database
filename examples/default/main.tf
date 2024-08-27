module "vault_db" {
  source      = "../../"
  db_username = "postgres"
  db_password = "postgres"
  db_hostname = "postgres"
  db_tcp_port = 5432
}
