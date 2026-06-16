#!/usr/bin/env bash
set -euo pipefail

echo "Asserting cluster management namespace topology existence..."
kubectl create namespace argocd --dry-run=client -o yaml | kubectl apply -f -

echo "Injecting primary Infra-Web-Cloud GitOps target system..."
kubectl apply -f Cluster_Setup/ArgoCD_Application.yaml

echo "Awaiting system convergence loop..."
kubectl wait --namespace argocd \
  --for=condition=Ready \
  pod -l app.kubernetes.io/name=argocd-server \
  --timeout=90s
