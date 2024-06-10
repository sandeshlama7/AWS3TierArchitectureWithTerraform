locals {
  region              = var.region
  vpc_cidr            = var.vpc_cidr
  ami                 = var.ami
  instance_type       = var.instance_type
  owner_tag           = var.owner_tag
  cidr_all            = var.cidr_all
  subnets-conf        = var.subnets-conf
  rds_db_name         = var.rds_db_name
  rds_engine          = var.rds_engine
  rds_engine_version  = var.rds_engine_version
  rds_parameter_group = var.rds_parameter_group
  rds_username        = var.rds_username
  rds_pass            = var.rds_pass
}
