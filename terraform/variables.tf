variable "region" {
  default = "ap-south-1"
}

variable "project_name" {
  default = "strapi-ecs"
}

variable "container_port" {
  default = 1337
}

variable "db_username" {}
variable "db_password" {
  sensitive = true
}
