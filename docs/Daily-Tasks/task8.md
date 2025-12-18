Task #8 – Strapi Deployment on AWS ECS Fargate with Terraform, GitHub Actions & CloudWatch Monitoring
Overview

This task extends the ECS Fargate–based Strapi deployment by adding observability and monitoring using AWS CloudWatch, while keeping the entire system fully automated via Terraform and GitHub Actions (CI/CD).

The deployment, logging, metrics collection, and monitoring configuration are all managed as code with no manual AWS console intervention.

Objectives

Deploy Strapi on AWS ECS Fargate

Manage infrastructure entirely with Terraform

Automate build & deployment using GitHub Actions

Centralize logs using CloudWatch Log Groups

Enable ECS service metrics

Monitor application health and resource usage

High-Level Architecture

Code push triggers GitHub Actions CI/CD pipeline

Docker image is built and tagged

Image is pushed to AWS ECR

Terraform updates ECS task definition

New task revision is deployed on ECS Fargate

Application logs are streamed to CloudWatch

ECS metrics are collected and visualized

Repository Structure
.
├── .github/
│   └── workflows/
│       └── deploy.yml
├── terraform/
│   ├── ecs.tf
│   ├── ecr.tf
│   ├── cloudwatch.tf
│   ├── iam.tf
│   ├── networking.tf
│   ├── variables.tf
│   └── outputs.tf
├── strapi/
│   ├── Dockerfile
│   └── ...
└── README.md

GitHub Actions – CI/CD Pipeline
Workflow File
.github/workflows/deploy.yml

Trigger

Runs automatically on push to main

CI/CD Pipeline Responsibilities
1. Build & Push Docker Image

Checkout repository

Build Strapi Docker image

Tag image with Git commit SHA

Authenticate with AWS ECR

Push image to ECR

2. Terraform Deployment

Terraform init

Terraform plan

Terraform apply

Update ECS task definition with new image

Deploy updated task revision to ECS service

CloudWatch Logging Configuration
CloudWatch Log Group

Created using Terraform

Log group name:

/ecs/strapi

ECS Task Definition Logging

Log driver: awslogs

Logs streamed directly from containers to CloudWatch

Log stream prefix:

ecs/strapi


This enables centralized logging for:

Application logs

Container startup logs

Runtime errors

CloudWatch Metrics Enabled

The ECS service automatically publishes the following metrics to CloudWatch:

Resource Metrics

CPU Utilization

Memory Utilization

Task & Service Metrics

Running Task Count

Desired Task Count

Task Restart Count

Network Metrics

Network In

Network Out

These metrics help track application performance and ECS health in real time.

Optional Monitoring Enhancements
CloudWatch Dashboards

Visualize CPU and memory usage

Track task count and service stability

Monitor traffic trends

CloudWatch Alarms

High CPU utilization

High memory usage

Task failure or unexpected restarts

Unhealthy service state

Application-Level Monitoring (Optional)

Application response latency (via ALB metrics)

Error rate monitoring

Health check failures

AWS Resources Managed via Terraform

ECS Cluster

ECS Task Definition

ECS Service (Fargate)

ECR Repository

CloudWatch Log Group

IAM Roles and Policies

VPC, Subnets, Security Groups

Application Load Balancer

CloudWatch Metrics & Alarms (optional)

GitHub Secrets Used

The following secrets are configured securely in GitHub:

AWS_ACCESS_KEY_ID

AWS_SECRET_ACCESS_KEY

AWS_REGION

ECR_REPOSITORY

ECS_CLUSTER_NAME

ECS_SERVICE_NAME

Verification

After deployment:

Confirm ECS service is running healthy tasks

Check CloudWatch Logs under:

/ecs/strapi


Verify metrics in CloudWatch → ECS

Access Strapi via Load Balancer DNS

Confirm logs update in real time

Key Learnings

Implemented production-grade observability

Centralized logging with CloudWatch

Enabled ECS service metrics monitoring

Automated monitoring setup using Terraform

Integrated CI/CD with infrastructure and monitoring

Achieved zero-touch deployments with full visibility

Status

✅ Task completed successfully
Strapi deployed on ECS Fargate with automated CI/CD and CloudWatch monitoring enabled

Possible Next Improvements

Add autoscaling based on CPU/memory

Integrate X-Ray for tracing

Push logs to OpenSearch

Add HTTPS using ACM

Add alert notifications (SNS / Slack)