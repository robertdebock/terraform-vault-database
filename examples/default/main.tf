module "vault_db" {
  source      = "../../"
  db_username = "postgres"
  db_password = "postgres"
  # db_hostname = "95.217.128.202"
  db_tcp_port = 5432
  depends_on = [
    docker_container.vault,
    docker_container.postgres
  ]
}
