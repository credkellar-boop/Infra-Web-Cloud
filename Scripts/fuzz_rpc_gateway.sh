#!/usr/bin/env bash
set -euo pipefail

TARGET_RPC_URL="http://127.0.0.1:8545"
echo "Beginning fuzz injection analysis against public RPC interfaces..."

# Use high-throughput connections with corrupted payload matrices
wrk -t4 -c200 -d30s \
  -s <(echo '
    request = function()
      local malformed_bytes = "\\x4D\\xFF\\xFF\\xFF" .. string.rep("A", 128)
      return wrk.format("POST", "/", {["Content-Type"]="application/json"}, malformed_bytes)
    end
  ') "${TARGET_RPC_URL}"

echo "Fuzz iteration completed. Checking cluster kernel metrics status..."
kubectl logs -n core-infrastructure -l app=blockchain-rpc-accelerator --tail=20
