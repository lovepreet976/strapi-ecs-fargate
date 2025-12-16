resource "aws_s3_bucket" "uploads" {
  bucket = "${var.project_name}-uploads"
}

output "s3_bucket_name" {
  value = aws_s3_bucket.uploads.bucket
}
