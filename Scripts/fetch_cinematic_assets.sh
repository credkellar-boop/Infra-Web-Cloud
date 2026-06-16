#!/usr/bin/env bash
set -euo pipefail

echo "Authenticating via Vault to retrieve 3D cinematic repository assets..."
VAULT_TOKEN=$(vault print token)

ASSET_URL=$(curl -s -H "X-Vault-Token: ${VAULT_TOKEN}" \
  https://127.0.0.1:8200/v1/secret/data/repository/assets | jq -r '.data.data.logo_url')

mkdir -p Docs/Assets
echo "Downloading high-resolution 4k storefront imagery..."
curl -s -o Docs/Assets/Primary_Logo_3D.png "${ASSET_URL}"

echo "Assets synchronized successfully."
