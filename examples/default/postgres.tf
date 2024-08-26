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
