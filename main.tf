## VPC
resource "aws_vpc" "vpc-sandesh" {
  cidr_block = local.vpc_cidr
  tags = {
    Name = "vpc-terraform-sandesh"
  }
}

# SUBNETS
resource "aws_subnet" "subnets" {
  for_each = local.subnets-conf

  vpc_id            = aws_vpc.vpc-sandesh.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az
  tags = {
    Name = each.key
  }
}

# VPC-SECURITY-GROUP
resource "aws_security_group" "sg-vpc" {
  name        = "Sg-VPC-Terraform-Sandesh"
  description = "Security Group For The VPC"
  vpc_id      = aws_vpc.vpc-sandesh.id
  tags = {
    Name = "SG-VPC"
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

## INTERNET GATEWAY
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.vpc-sandesh.id
  tags = {
    Name = "IGW-Terra-Sandesh"
  }
}

## NAT GATEWAY
resource "aws_eip" "eIP" {
  domain = "vpc"
  tags = {
    Name = "eIP-Sandesh"
  }
}

resource "aws_nat_gateway" "NAT" {
  subnet_id     = aws_subnet.subnets["public-subnet-1a"].id
  allocation_id = aws_eip.eIP.id
  tags = {
    Name = "NAT-Sandesh"
  }
}

#PUBLIC Route Table
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.vpc-sandesh.id

  route {
    cidr_block = local.cidr_all
    gateway_id = aws_internet_gateway.IGW.id
  }
  tags = {
    Name = "Public-Subnet-RT"
  }
}

##PRIVATE ROUTE TABLE
resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.vpc-sandesh.id
  route {
    cidr_block = local.cidr_all
    gateway_id = aws_nat_gateway.NAT.id
  }
  tags = {
    Name = "Private-Subnet-RT"
  }
}

##ROUTE TABLE ASSOCIATION TO SUBNETS
resource "aws_route_table_association" "public_subnet_association1" {
  subnet_id      = aws_subnet.subnets["public-subnet-1a"].id
  route_table_id = aws_route_table.public-route-table.id
}
resource "aws_route_table_association" "public_subnet_association2" {
  subnet_id      = aws_subnet.subnets["public-subnet-1b"].id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "private_subnet_association1" {
  subnet_id      = aws_subnet.subnets["private-subnet-1a"].id
  route_table_id = aws_route_table.private-route-table.id
}
resource "aws_route_table_association" "private_subnet_association2" {
  subnet_id      = aws_subnet.subnets["private-subnet-1b"].id
  route_table_id = aws_route_table.private-route-table.id
}
