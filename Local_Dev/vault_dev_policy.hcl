# Retain your existing local KV secret space
path "secret/data/local/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

# Standard token lookup paths for local dev authentications
path "auth/token/lookup" {
  capabilities = ["read"]
}

path "auth/token/lookup-self" {
  capabilities = ["read"]
}

# =====================================================================
# MANDATORY CRYPTO OPERATIONS FOR THE CONVERGED VALIDATOR LAYER
# =====================================================================

# Allows full lifecycle management of the core validation keys locally
path "transit/keys/monad-validator-key" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

# Explicitly lets rotate_validator_keys.sh trigger key versioning
path "transit/keys/monad-validator-key/rotate" {
  capabilities = ["update"]
}

# Allows the mock Python VSOCK enclave to compute data signatures
path "transit/sign/monad-validator-key" {
  capabilities = ["update"]
}

path "transit/verify/monad-validator-key" {
  capabilities = ["update"]
}
