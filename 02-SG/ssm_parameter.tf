resource "aws_ssm_parameter" "mongodb_sg_id" {
  name  = "/${var.project}/${var.environment}/mongodb_sg_id"
  type  = "String"
  value = module.mongodb.sg_id
}

resource "aws_ssm_parameter" "catalogue_sg_id" {
  name  = "/${var.project}/${var.environment}/catalogue_sg_id"
  type  = "String"
  value = module.catalogue.sg_id
}
resource "aws_ssm_parameter" "user_sg_id" {
  name  = "/${var.project}/${var.environment}/user_sg_id"
  type  = "String"
  value = module.user.sg_id
}

resource "aws_ssm_parameter" "cart_sg_id" {
  name  = "/${var.project}/${var.environment}/cart_sg_id"
  type  = "String"
  value = module.cart.sg_id
}

resource "aws_ssm_parameter" "shipping_sg_id" {
  name  = "/${var.project}/${var.environment}/shipping_sg_id"
  type  = "String"
  value = module.shipping.sg_id
}

resource "aws_ssm_parameter" "payment_sg_id" {
  name  = "/${var.project}/${var.environment}/payment_sg_id"
  type  = "String"
  value = module.payment.sg_id
}

resource "aws_ssm_parameter" "dispatch_sg_id" {
  name  = "/${var.project}/${var.environment}/dispatch_sg_id"
  type  = "String"
  value = module.dispatch.sg_id
}

resource "aws_ssm_parameter" "mysql_sg_id" {
  name  = "/${var.project}/${var.environment}/mysql_sg_id"
  type  = "String"
  value = module.mysql.sg_id
}

resource "aws_ssm_parameter" "rabbitmq_sg_id" {
  name  = "/${var.project}/${var.environment}/rabbitmq_sg_id"
  type  = "String"
  value = module.rabbitmq.sg_id
}

resource "aws_ssm_parameter" "redis_sg_id" {
  name  = "/${var.project}/${var.environment}/redis_sg_id"
  type  = "String"
  value = module.redis.sg_id
}

resource "aws_ssm_parameter" "web_sg_id" {
  name  = "/${var.project}/${var.environment}/web_sg_id"
  type  = "String"
  value = module.web.sg_id
}

resource "aws_ssm_parameter" "openvpn_sg_id" {
  name  = "/${var.project}/${var.environment}/openvpn_sg_id"
  type  = "String"
  value = module.openvpn.sg_id
}