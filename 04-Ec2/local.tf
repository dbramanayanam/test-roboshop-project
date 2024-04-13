locals {
  database_subnet_ids = element(split(",", data.aws_ssm_parameter.database_subnet_ids.value),0)
}


locals {
  public_subnet_ids  = element(split(",", data.aws_ssm_parameter.public_subnet_ids.value),0)
}


locals {
  private_subnet_ids  = element(split(",", data.aws_ssm_parameter.private_subnet_ids.value),0)
}

locals {
  ec2_name = "${var.project}-${var.environment}"
}
