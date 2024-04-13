resource "aws_ssm_parameter" "vpc_id" {
  name  = "/${var.project}/${var.environment}/vpc.id"
  type  = "String"
  value = module.roboshop.aws_vpc_id
}


resource "aws_ssm_parameter" "default_vpc_id" {
  name  = "/${var.project}/${var.environment}/default_vpc_id"
  type  = "String"
  value = module.roboshop.aws_default_vpc
}


resource "aws_ssm_parameter" "public_subnet_ids" {
  name  = "/${var.project}/${var.environment}/public_subnet_ids"
  type  = "StringList"
  value = join(",", module.roboshop.aws_subnet_public_ids)
}

resource "aws_ssm_parameter" "private_subnet_ids" {
  name  = "/${var.project}/${var.environment}/private_subnet_ids"
  type  = "StringList"
  value = join(",", module.roboshop.aws_subnet_private_ids)
}

resource "aws_ssm_parameter" "database_subnet_ids" {
  name  = "/${var.project}/${var.environment}/database_subnet_ids"
  type  = "StringList"
  value = join(",", module.roboshop.aws_subnet_database_ids)
}
