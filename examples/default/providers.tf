terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "vault" {
  address = "http://${docker_container.vault.hostname}:8200"
  token   = "root"
}
