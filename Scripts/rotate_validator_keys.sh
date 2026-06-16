#!/usr/bin/env bash
set -euo pipefail

export VAULT_ADDR="https://127.0.0.1:8200"

echo "Contacting Vault Transit Engine to cycle consensus-signing key iterations..."
vault write -f transit/keys/monad-validator-key/rotate

echo "Verifying latest active structural tracking version context..."
vault read transit/keys/monad-validator-key | grep -E "latest_version"

echo "Cryptographic rotation loop systematically verified."
