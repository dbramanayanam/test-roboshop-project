locals {
  name = "${var.project}-${var.environment}" 
  value = slice(data.aws_availability_zones.available.names,0,2)
}