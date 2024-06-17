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
}
variable "owner_tag" {
  description = "Values for owner Tags"
  type        = string
}
variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}
variable "ami" {
  description = "AMI for our instance"
  type        = string
}
variable "instance_type" {
  description = "instance type for ec2"
  type        = string
}
variable "cidr_all" {
  description = "All CIDRs"
  type        = string
}
variable "rds_db_name" {}
variable "rds_engine" {}
variable "rds_engine_version" {}
variable "rds_username" {}
variable "rds_pass" {}
variable "rds_parameter_group" {}
