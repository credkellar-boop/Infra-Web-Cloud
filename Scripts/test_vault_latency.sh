#!/usr/bin/env bash
set -euo pipefail

export VAULT_ADDR="https://127.0.0.1:8200"
export VAULT_TOKEN="root_token_placeholder"

echo "Measuring cryptographic loop latency over transit engine..."
for i in {1..5}; do
    curl -o /dev/null -s -w "Pass ${i} Connect: %{time_connect}s | Total: %{time_total}s\n" \
      -H "X-Vault-Token: ${VAULT_TOKEN}" \
      -X POST "${VAULT_ADDR}/v1/secret/data/benchmark"
done
