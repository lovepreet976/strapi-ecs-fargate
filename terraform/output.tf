output "ecr_repository_url" {
  description = "ECR repository URL"
  value       = aws_ecr_repository.strapi.repository_url
}

#output "ecr_repository_name" {
#  description = "ECR repository name"
#  value       = aws_ecr_repository.strapi.name
#}
  

  output "rds_endpoint" {
  value = aws_db_instance.postgres.address
}

output "s3_bucket" {
  value = aws_s3_bucket.uploads.bucket
}
