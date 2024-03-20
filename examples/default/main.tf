module "vault_db" {
  source      = "../../"
  db_username = "postgres"
  db_password = "postgres"
  db_hostname = "postgres"
}
