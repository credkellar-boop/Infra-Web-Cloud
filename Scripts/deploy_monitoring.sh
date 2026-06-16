#!/usr/bin/env bash
set -euo pipefail

echo "Provisioning core infrastructure metrics definitions..."
kubectl apply -f Deploy_Manifests/K8s_Manifests/Hubble_Grafana_Dashboard.yaml

echo "Validating active scrape targeting maps..."
kubectl rollout status deployment/grafana-core -n core-infrastructure --timeout=60s

echo "Cluster monitoring fabrics securely converged."
