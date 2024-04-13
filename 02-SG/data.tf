data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project}/${var.environment}/vpc.id"
}


data "aws_ssm_parameter" "default_vpc_id" {
  name = "/${var.project}/${var.environment}/default_vpc_id"
}

# output "default_vpc_id" {
#   value       = data.aws_ssm_parameter.default_vpc_id.value

# }
