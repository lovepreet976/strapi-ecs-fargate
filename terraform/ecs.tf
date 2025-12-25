############################################
# CloudWatch Log Group
############################################
resource "aws_cloudwatch_log_group" "strapi" {
  name              = "/ecs/strapi"
  retention_in_days = 7
}

############################################
# ECS Cluster
############################################
resource "aws_ecs_cluster" "main" {
  name = "strapi-cluster"
}

############################################
# ECS Capacity Providers (FARGATE_SPOT)
############################################
resource "aws_ecs_cluster_capacity_providers" "strapi" {
  cluster_name = aws_ecs_cluster.main.name

  capacity_providers = [
    "FARGATE",
    "FARGATE_SPOT"
  ]

  default_capacity_provider_strategy {
    capacity_provider = "FARGATE_SPOT"
    weight            = 1
  }
}

############################################
# ECS Task Definition
############################################
resource "aws_ecs_task_definition" "strapi" {
  family                   = "strapi-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "512"
  memory                   = "1024"

  execution_role_arn = aws_iam_role.ecs_execution.arn
  task_role_arn      = aws_iam_role.ecs_task_role.arn

  container_definitions = jsonencode([
    {
      name  = "strapi"
      image = var.image_url

      portMappings = [
        {
          containerPort = 1337
          protocol      = "tcp"
        }
      ]

      environment = [
        { name = "DATABASE_CLIENT", value = "postgres" },
        { name = "DATABASE_HOST", value = aws_db_instance.postgres.address },
        { name = "DATABASE_PORT", value = "5432" },
        { name = "DATABASE_NAME", value = "strapi" },
        { name = "DATABASE_USERNAME", value = var.db_username },
        { name = "DATABASE_PASSWORD", value = var.db_password },

        { name = "AWS_BUCKET", value = aws_s3_bucket.uploads.bucket },

        { name = "DATABASE_SSL", value = "true" },
        { name = "DATABASE_SSL_REJECT_UNAUTHORIZED", value = "false" }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.strapi.name
          awslogs-region        = var.region
          awslogs-stream-prefix = "ecs/strapi"
        }
      }
    }
  ])
}

############################################
# ECS Service (ALB + FARGATE_SPOT + CODE_DEPLOY)
############################################
resource "aws_ecs_service" "strapi" {
  name            = "strapi-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.strapi.arn
  desired_count   = 1

  capacity_provider_strategy {
    capacity_provider = "FARGATE_SPOT"
    weight            = 1
  }

  enable_execute_command = true

  deployment_controller {
    type = "CODE_DEPLOY"
  }

  depends_on = [
    aws_ecs_cluster_capacity_providers.strapi,
    aws_lb_listener.http,
    aws_db_instance.postgres,
    aws_iam_role_policy_attachment.ecs_exec_policy,
    aws_iam_role_policy_attachment.ecs_task_s3
  ]

  network_configuration {
    subnets = [
      aws_subnet.private_1.id,
      aws_subnet.private_2.id
    ]
    security_groups = [aws_security_group.ecs_sg.id]
  }

  # IMPORTANT: attach ONLY to BLUE target group
  load_balancer {
    target_group_arn = aws_lb_target_group.blue.arn
    container_name   = "strapi"
    container_port   = 1337
  }
}
