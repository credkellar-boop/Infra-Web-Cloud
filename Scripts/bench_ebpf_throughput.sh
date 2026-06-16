#!/usr/bin/env bash
set -euo pipefail

echo "Executing kernel networking saturation telemetry checks..."
TARGET_IP="10.0.0.100"

for interval in {1..3}; do
    echo "Running step ${interval} calculation loop..."
    wrk -t2 -c100 -d10s "https://${TARGET_IP}/healthz"
done
