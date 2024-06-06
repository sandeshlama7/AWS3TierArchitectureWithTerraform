variable "subnets-conf" {
  description = "CIDR for Subnets"
  type = map(object({
    cidr = string
    az   = string
  }))
  default = {
    "public-subnet-1a" = {
      cidr = "10.0.0.0/22"
      az   = "us-east-1a"
    }
    "private-subnet-1a" = {
      cidr = "10.0.4.0/22"
      az   = "us-east-1a"
    }
    "public-subnet-1b" = {
      cidr = "10.0.8.0/22"
      az   = "us-east-1b"
    }
    "private-subnet-1b" = {
      cidr = "10.0.12.0/22"
      az   = "us-east-1b"
    }
  }
}
variable "region" {
  description = "Region"
  type        = string
  default     = "us-east-1"
}
variable "owner_tag" {
  description = "Values for owner Tags"
  type        = string
  default     = "sandesh.lama"
}
variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}
variable "ami" {
  description = "AMI for our instance"
  type        = string
  default     = "ami-00beae93a2d981137"
}
variable "instance_type" {
  description = "instance type for ec2"
  type        = string
  default     = "t2.micro"
}
