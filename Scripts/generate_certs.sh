#!/usr/bin/env bash
set -euo pipefail

echo "Generating localized SAN infrastructure certificates..."
mkdir -p Local_Dev/certs

openssl req -x509 -newkey rsa:4096 -days 365 -nodes \
  -keyout Local_Dev/certs/vault.key \
  -out Local_Dev/certs/vault.crt \
  -subj "/CN=localhost" \
  -addext "subjectAltName = DNS:localhost, IP:127.0.0.1"

echo "Certificates systematically generated inside Local_Dev/certs/"
