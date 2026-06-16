#!/usr/bin/env bash
set -euo pipefail

echo "Scanning cluster for eBPF Cilium state definitions..."
CILIUM_POD=$(kubectl get pods -n core-infrastructure -l k8s-app=cilium -o jsonpath='{.items[0].metadata.name}')

echo "Extracting active BPF connection tracking maps from: ${CILIUM_POD}"
kubectl exec -n core-infrastructure "${CILIUM_POD}" -c cilium-agent -- cilium bpf ct list global
