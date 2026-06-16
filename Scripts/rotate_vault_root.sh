#!/usr/bin/env bash
set -euo pipefail

export VAULT_ADDR="https://127.0.0.1:8200"

echo "Initializing security master validation keys rotation..."
vault operator rekey -init -key-shares=5 -key-threshold=3

echo "Rotation mechanism initialized successfully. Key holders must present unseal shards."
