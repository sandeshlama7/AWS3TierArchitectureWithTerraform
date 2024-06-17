resource "aws_security_group" "SG-Public" {
  name        = "SG-Public"
  description = "SG for the Public Instance"
  vpc_id      = aws_vpc.vpc-sandesh.id
  tags = {
    Name = "SG-Public"
  }
  ingress {
    description = "Allow HTTP"
    cidr_blocks = [local.cidr_all]
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
  }
  ingress {
    description = "Allow HTTPS"
    cidr_blocks = [local.cidr_all]
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
  }

  egress {
    description = "Outbound Rules to Allow All Outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [local.cidr_all]
  }
}

resource "aws_security_group" "SG-Private" {
  name        = "SG-Private"
  description = "SG for Private Instance"
  vpc_id      = aws_vpc.vpc-sandesh.id
  tags = {
    Name = "SG-Private"
  }

  ingress {
    description = "Allow HTTP from the public instance"
    cidr_blocks = [aws_subnet.subnets["public-subnet-1a"].cidr_block]
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
  }
  ingress {
    description = "Allow traffic from the public instance on port 8080"
    cidr_blocks = [aws_subnet.subnets["public-subnet-1a"].cidr_block]
    from_port   = 8080
    protocol    = "tcp"
    to_port     = 8080
  }
  egress {
    description = "Outbound Rules to Allow All Outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [local.cidr_all]
  }
}

data "aws_iam_instance_profile" "IAM-Role" {
  name = "ec2-SSM-Sandesh"
}

resource "aws_instance" "public-instance" {
  ami                         = local.ami
  instance_type               = local.instance_type
  subnet_id                   = aws_subnet.subnets["public-subnet-1a"].id
  security_groups             = [aws_security_group.SG-Public.id]
  iam_instance_profile        = data.aws_iam_instance_profile.IAM-Role.name
  associate_public_ip_address = "true"
  tags = {
    Name    = "Public-EC2"
    project = "ec2-creation"

  }
  user_data = base64encode("${templatefile("userdata/public.sh", {
    PRIVATE_SERVER_IP = aws_instance.private-instance.private_ip
  })}")

  # user_data = file("userdata/public.sh")
}

resource "aws_instance" "private-instance" {
  ami                         = local.ami
  instance_type               = local.instance_type
  subnet_id                   = aws_subnet.subnets["private-subnet-1a"].id
  associate_public_ip_address = "false"
  security_groups             = [aws_security_group.SG-Private.id]

  tags = {
    Name    = "Private-EC2"
    project = "ec2-creation"
  }
  user_data = base64encode("${templatefile("userdata/priv.sh", {
    RDS_ENDPOINT = aws_db_instance.DB-Terraform-Sandesh.endpoint
  })}")
}
