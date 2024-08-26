# Vault database

A module to configure Vault by adding a dynamic secrets engine.

Supported databases:

- PostgreSQL (RDS)

## Setup

Please tell Terraform where Vault can be found:

```shell
export VAULT_ADDR=http://95.217.128.202:8200
export VAULT_TOKEN="root"
```
