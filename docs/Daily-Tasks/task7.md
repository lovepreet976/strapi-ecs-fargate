Task #7 – Deploying Strapi on AWS ECS Fargate using Terraform & GitHub Actions
Overview

This repository demonstrates a fully automated deployment of a Strapi application on AWS ECS Fargate, managed entirely using Terraform and GitHub Actions.

The complete workflow—from building a Docker image to updating the ECS task definition and deploying a new revision—is handled only through GitHub Actions, with no manual AWS console interaction.

Objectives

Deploy Strapi on AWS ECS Fargate

Manage infrastructure entirely using Terraform

Automate Docker image build and push

Update ECS task definition with new image

Deploy new task revision automatically

Use GitHub Actions as the single control plane

High-Level Architecture

Code is pushed to the main branch

GitHub Actions builds a new Docker image

Image is tagged with commit SHA

Image is pushed to AWS ECR

Terraform updates ECS task definition

ECS service deploys a new task revision

Strapi runs on ECS Fargate

Repository Structure
.
├── .github/
│   └── workflows/
│       └── deploy.yml
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── ecs.tf
│   ├── ecr.tf
│   └── networking.tf
├── strapi/
│   ├── Dockerfile
│   └── ...
└── README.md

GitHub Actions – CI/CD Pipeline
Workflow File
.github/workflows/deploy.yml

Trigger

Automatically runs on push to main

Pipeline Responsibilities
1. Build & Push Docker Image

Checkout source code

Build Docker image for Strapi

Tag image using Git commit SHA

Authenticate to AWS ECR

Push image to ECR repository

2. Terraform Infrastructure Management

Initialize Terraform

Apply Terraform configuration

Update ECS task definition with new image tag

Register new task revision

Deploy updated task to ECS Fargate service

AWS Resources Managed via Terraform

ECR Repository

ECS Cluster

ECS Task Definition

ECS Service (Fargate)

IAM Roles (Task Execution & Task Role)

Application Load Balancer

VPC, Subnets, Security Groups

CloudWatch Logs

ECS Deployment Details
ECS Task Definition

Launch type: FARGATE

Network mode: awsvpc

Container image pulled from ECR

Port mapping for Strapi (1337)

Environment variables managed via Terraform

ECS Service

Desired count managed by Terraform

Automatically deploys new task revision

Zero-downtime rolling updates

GitHub Secrets Used

The following secrets are configured in the repository:

AWS_ACCESS_KEY_ID

AWS_SECRET_ACCESS_KEY

AWS_REGION

ECR_REPOSITORY

ECS_CLUSTER_NAME

ECS_SERVICE_NAME

Deployment Flow Summary

No manual Terraform execution

No AWS Console usage

No local Docker build

Entire pipeline executed via GitHub Actions

Verification

After successful deployment:

Access the application via the Load Balancer DNS name

Confirm Strapi admin panel is accessible

Verify new ECS task revision is running

Key Learnings

End-to-end automation using GitHub Actions

Infrastructure as Code with Terraform

ECS Fargate deployment best practices

Image-based deployments using ECR

Zero-downtime task revision updates

Secure CI/CD using GitHub Secrets