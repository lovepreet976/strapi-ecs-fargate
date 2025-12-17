variable "region" {
  default = "ap-south-1"
}

variable "image_url" {
  description = "ECR image URL with tag"
  type        = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}
