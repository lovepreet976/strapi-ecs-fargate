Task #6 – Automated Strapi Deployment using GitHub Actions & Terraform
Overview

This repository implements a complete CI/CD pipeline to automate the build and deployment of a Strapi application using GitHub Actions and Terraform.
The solution ensures that application code changes are containerized automatically and deployed to an AWS EC2 instance in a controlled and reproducible manner.

Goals

Automate Docker image build on code push

Push Docker images to Docker Hub or AWS ECR

Deploy updated images using Terraform

Use GitHub Secrets for secure credentials

Deploy and verify Strapi via EC2 public IP

CI/CD Architecture

Code is pushed to the main branch

GitHub Actions CI workflow builds Docker image

Image is pushed to Docker Hub / AWS ECR

Image tag is exported as workflow output

Terraform workflow is triggered manually

Terraform provisions/updates EC2

EC2 pulls the new image and runs Strapi

Application is verified via public IP

Workflows
1. CI – Build & Push Docker Image

Workflow file

.github/workflows/ci.yml


Trigger

Automatically runs on push to main

Steps

Checkout source code

Build Strapi Docker image

Tag image (commit SHA or version)

Push image to Docker Hub or ECR

Save image tag as GitHub Actions output

2. CD – Infrastructure & Deployment (Terraform)

Workflow file

.github/workflows/terraform.yml


Trigger

Manual trigger using workflow_dispatch

Steps

Terraform init

Terraform plan

Terraform apply

Provision or update EC2 instance

Pull Docker image using CI-generated image tag

Run updated Strapi container on EC2

Infrastructure Details
EC2

Provisioned using Terraform

Docker installed automatically

SSH access enabled

Security Group allows:

Port 22 (SSH)

Port 1337 (Strapi)

Deployment

Old container is stopped (if running)

New container is started using latest image

Stateless deployment using Docker

GitHub Secrets Used

The following secrets are configured in the repository:

AWS_ACCESS_KEY_ID

AWS_SECRET_ACCESS_KEY

AWS_REGION

DOCKER_USERNAME / DOCKER_PASSWORD (or ECR credentials)

EC2_SSH_KEY

Verification

After successful deployment:

Get EC2 public IP from Terraform output

Open browser:

http://<EC2_PUBLIC_IP>:1337


Verify Strapi admin panel and APIs

Key Outcomes

Fully automated CI/CD pipeline

Dockerized Strapi application

Infrastructure managed using Terraform

Secure credential handling via GitHub Secrets

Reliable and repeatable deployments

Status

✅ Task completed successfully
CI and CD pipelines tested and verified using EC2 public IP