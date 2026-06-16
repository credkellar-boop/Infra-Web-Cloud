#!/usr/bin/env bash
set -euo pipefail

echo "Compiling structural Zig parser binary matrices..."
cd "$(dirname "$0")"
zig build --summary all

echo "Launching optimized libFuzzer loop over serialized byte bounds..."
./zig-out/bin/parser_fuzz_target \
  -max_total_time=120 \
  -rss_limit_mb=2048 \
  -malloc_context_size=10
