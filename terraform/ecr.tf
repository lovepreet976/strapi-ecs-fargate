resource "aws_ecr_repository" "strapi" {
  name = "strapi-app"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Project = "strapi-ecs"
    Managed = "terraform"
  }
  
  lifecycle {
    prevent_destroy = true
  }
}
