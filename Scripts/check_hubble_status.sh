#!/usr/bin/env bash
set -euo pipefail

echo "Querying eBPF Hubble API availability state..."
HUBBLE_POD=$(kubectl get pods -n core-infrastructure -l k8s-app=cilium -o jsonpath='{.items[0].metadata.name}')

echo "Verifying peer routing connectivity matrix inside: ${HUBBLE_POD}"
kubectl exec -n core-infrastructure "${HUBBLE_POD}" -c cilium-agent -- hubble status
