output "vpc_id" {
  value = aws_vpc.vpc-sandesh.id
}

output "instance_private_ip" {
  value = aws_instance.private-instance.private_ip
}
output "public-IP-publicEC2" {
  value = aws_instance.public-instance.public_ip
}
output "rds_endpoint" {
  value = aws_db_instance.DB-Terraform-Sandesh.endpoint
}
