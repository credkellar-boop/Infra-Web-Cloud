#!/usr/bin/env bash
set -euo pipefail

echo "Configuring 2MB Kernel Hugepages mapping thresholds..."
echo 1024 | sudo tee /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages

echo "Verifying active system reservation changes..."
grep HugePages_ /proc/meminfo

echo "Hugepages mapped. Hardware acceleration pipelines ready for runtime mounting."
