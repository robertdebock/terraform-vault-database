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
  depends_on = [
    docker_container.postgres
  ]
}
