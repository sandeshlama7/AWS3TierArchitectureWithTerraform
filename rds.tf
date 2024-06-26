resource "aws_db_instance" "DB-Terraform-Sandesh" {
  instance_class         = "db.t3.micro"
  allocated_storage      = 10
  db_name                = local.rds_db_name
  engine                 = local.rds_engine
  engine_version         = local.rds_engine_version
  username               = local.rds_username
  password               = local.rds_pass
  parameter_group_name   = local.rds_parameter_group
  db_subnet_group_name   = aws_db_subnet_group.rds-subnets.name
  vpc_security_group_ids = [aws_security_group.SG-RDS.id]
  publicly_accessible    = false
  skip_final_snapshot    = true
  identifier             = "db-terraform-sandesh"
}

resource "aws_security_group" "SG-RDS" {
  name        = "SG-RDS"
  description = "SG for RDS DB Instance"
  vpc_id      = aws_vpc.vpc-sandesh.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.SG-Private.id]
  }
  tags = {
    Name = "SG-RDS"
  }
}

resource "aws_db_subnet_group" "rds-subnets" {
  name       = "rds-subnets"
  subnet_ids = [aws_subnet.subnets["public-subnet-1a"].id, aws_subnet.subnets["public-subnet-1b"].id]
  tags = {
    Name = "rds-subnets-group"
  }
}
