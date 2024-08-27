resource "docker_network" "default" {
  name   = "my_network"
  driver = "bridge"
}

# resource "time_sleep" "default" {
#   create_duration = "30s"
# }

# module "vault_db" {
#   source      = "../../"
#   db_username = "postgres"
#   db_password = "postgres"
#   db_hostname = "postgres"
#   db_tcp_port = 5432
#   depends_on = [
#     docker_container.vault,
#     docker_container.postgres,
#     time_sleep.default
#   ]
# }
