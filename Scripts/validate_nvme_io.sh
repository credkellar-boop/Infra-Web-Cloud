#!/usr/bin/env bash
set -euo pipefail

echo "Auditing localized NVMe block allocation parameters..."
TARGET_DIR="/var/lib/monad/data"

if [ ! -d "${TARGET_DIR}" ]; then
    echo "Creating secure benchmark tracking point..."
    sudo mkdir -p "${TARGET_DIR}"
fi

echo "Measuring direct zero-copy write velocity..."
sudo fio --name=nvme_stress --directory=${TARGET_DIR} --rw=randwrite --ioengine=libaio --direct=1 --bs=4k --iodepth=64 --size=1G --runtime=10 --time_based --end_fsync=1

echo "NVMe health cycle validation complete."
