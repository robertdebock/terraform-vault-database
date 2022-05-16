# Vault database

A module to configure Vault by adding a dynamic secrets engine.

Supported databases:

- PostgreSQL (RDS)

## Setup

Please tell Terraform where Vault can be found:

```shell
export VAULT_ADDR=http://127.0.0.1:8200
export VAULT_TOKEN="hvs.YoUrToKeN."
```

Then set the AWS environment variables for Terraform:

```shell
export AWS_ACCESS_KEY_ID="anaccesskey"
export AWS_SECRET_ACCESS_KEY="asecretkey"
export AWS_REGION="us-west-2"
```

