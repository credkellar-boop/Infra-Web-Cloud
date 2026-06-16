#!/usr/bin/env bash
set -euo pipefail

echo "Mapping system architectural symbols for localized eBPF compilation..."
sudo apt-get update && sudo apt-get install -y linux-headers-$(uname -r) libbpf-dev

if [ ! -d "/sys/kernel/debug/tracing" ]; then
    echo "Mounting debug virtual tracing subsystem..."
    sudo mount -t debugfs debugfs /sys/kernel/debug
fi
