# Permit transit operations exclusively on specific validator signing frames
path "transit/keys/monad-validator-key" {
  capabilities = ["read"]
}

path "transit/sign/monad-validator-key" {
  capabilities = ["update"]
}

path "transit/verify/monad-validator-key" {
  capabilities = ["update"]
}

# Explicit deny rules preventing administrative policy extraction by application runners
path "sys/policies/*" {
  capabilities = ["deny"]
}
