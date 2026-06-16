#!/usr/bin/env bash
set -euo pipefail

echo "Spawning concurrent asynchronous driver auditing matrix..."
mkdir -p Security_Fuzzing/fuzz_results

./io_uring_fuzz_target \
  -max_total_time=600 \
  -artifact_prefix=Security_Fuzzing/fuzz_results/ \
  -workers=4 \
  -jobs=4
