#!/usr/bin/env bash
set -euo pipefail

export VAULT_ADDR="https://127.0.0.1:8200"

echo "Initializing Vault secret engines..."
vault secrets enable -path=secret kv-v2

echo "Configuring cluster authentication mapping..."
vault auth enable kubernetes

vault write auth/kubernetes/config \
    kubernetes_host="https://kubernetes.default.svc:443"

echo "Vault boot process completed successfully."
