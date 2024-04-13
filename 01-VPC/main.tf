module "roboshop" {
  source = "../Modules/VPC/"
  #source = "git::https://github.com/dbramanayanam/Terraform-vpc-module.git?ref=main"
  vpc_cidr_block = var.vpc_cidr_block
  project = var.project
  environment = var.environment
  common_tags = var.common_tags
  vpc_tags = var.vpc_tags
  #igw_tags = var.igw_tags
  public_cidr = var.public_cidr
  private_cidr = var.private_cidr
  database_cidr = var.database_cidr
}
