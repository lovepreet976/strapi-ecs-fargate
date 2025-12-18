resource "aws_db_subnet_group" "strapi" {
  name       = "strapi-db-subnet-group"
  subnet_ids = [
    aws_subnet.private_1.id,
    aws_subnet.private_2.id
  ]

  tags = {
    Name = "strapi-db-subnet-group"
  }
}
