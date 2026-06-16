#!/usr/bin/env bash
set -euo pipefail

echo "Executing structural compliance audit over current runtime target..."

# Flag any namespaces bypassing the default security runtime profiles
kubectl get pods --all-namespaces -o jsonpath='{range .items[*]}{.metadata.namespace}{"\t"}{.metadata.name}{"\t"}{.spec.containers[*].securityContext.privileged}{"\n"}{end}' \
  | grep "true" || echo "No rogue privileged context profiles uncovered."
