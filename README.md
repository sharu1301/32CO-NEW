# Node.js on EKS – DevOps Assessment

## Architecture
- Terraform for EKS, RDS, and ECR
- GitHub Actions for CI/CD
- Node.js App with Docker & Kubernetes
- Monitoring with Prometheus & Grafana

## How to Deploy
1. Set GitHub Secrets
2. Push to `main` branch
3. GitHub Actions will:
   - Provision infra (EKS, RDS, ECR)
   - Build & push Docker image
   - Deploy to EKS
   - Set up monitoring

## Secrets
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_REGION`
- `EKS_CLUSTER_NAME`
- `RDS_PASSWORD`
- `GRAFANA_ADMIN_PASSWORD`

## Monitoring
- Grafana Dashboard: `/health` and `/ready` endpoints scraped

