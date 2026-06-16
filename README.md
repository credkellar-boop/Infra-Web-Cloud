# Infra-Web-Cloud

A unified high-performance cloud orchestration engine merging eBPF networking via Cilium, cryptographic key security via HashiCorp Vault, and API-driven immutable infrastructure via Talos Linux. Automated using Pulumi IaC and ArgoCD GitOps for automated, zero-trust bare-metal deployment.

## Structural Strategy
- **Deploy_Manifests/**: Programmatic infrastructure topology matrices via Go-driven Pulumi configurations.
- **Cluster_Setup/**: Hardened OS configurations via API-driven minimal Talos Linux.
- **Security_Fuzzing/**: Automated verification tools to check local code validation and driver resilience.

## Local Execution
To trigger structural validation cycles across the container engine:
```bash
cd Local_Dev
docker compose -f docker-compose.local.yml up --build
