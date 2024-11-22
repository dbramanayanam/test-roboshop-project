locals {
  database_subnet_ids = element(split(",", data.aws_ssm_parameter.database_subnet_ids.value),0)
}


locals {
  ec2_name = "${var.project}-${var.environment}"
}
