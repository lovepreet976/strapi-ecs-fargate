# Strapi on AWS ECS Fargate

## Architecture
- ECS Fargate
- ECR
- RDS (Postgres)
- S3 (Uploads)
- Terraform
- GitHub Actions

## CI/CD
- Build & push Docker image on push
- Deploy ECS using GitHub Actions only

## Access
Application runs on port 1337 via ALB
