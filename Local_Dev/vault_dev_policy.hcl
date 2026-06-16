path "secret/data/local/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "auth/token/lookup" {
  capabilities = ["read"]
}
