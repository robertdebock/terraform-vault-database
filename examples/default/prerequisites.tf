resource "docker_network" "default" {
  name   = "my_network"
  driver = "bridge"
}

resource "docker_image" "postgres" {
  name = "postgres"
}

resource "docker_container" "postgres" {
  name  = "postgres"
  image = docker_image.postgres.image_id
  env = [
    "POSTGRES_USER=postgres",
    "POSTGRES_PASSWORD=postgres",
    "POSTGRES_DB=postgres"
  ]
  ports {
    internal = 5432
    external = 5432
  }
  networks_advanced {
    name = docker_network.default.name
  }
  healthcheck {
    test     = ["CMD", "pg_isready", "-U", "postgres"]
    interval = "10s"
    timeout  = "5s"
  }
}

resource "docker_image" "vault" {
  name = "hashicorp/vault"
}

resource "docker_container" "vault" {
  name  = "vault"
  image = docker_image.vault.image_id
  env = [
    "VAULT_DEV_ROOT_TOKEN_ID=root",
    "VAULT_DEV_LISTEN_ADDRESS=0.0.0.0:8200"
  ]
  ports {
    internal = 8200
    external = 8200
  }
  networks_advanced {
    name = docker_network.default.name
  }
  depends_on = [
    docker_container.postgres
  ]
}
