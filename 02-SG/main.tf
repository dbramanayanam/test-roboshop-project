module "mongodb" {
source = "../Modules/SG/"
common_tags = var.common_tags
vpc_id = data.aws_ssm_parameter.vpc_id.value
project = var.project
environment = var.environment
sg_name = "mongodb"
}

module "catalogue" {
source = "../Modules/SG/"
common_tags = var.common_tags
vpc_id = data.aws_ssm_parameter.vpc_id.value
project = var.project
environment = var.environment
sg_name = "catalogue"
}

module "user" {
source = "../Modules/SG/"
common_tags = var.common_tags
vpc_id = data.aws_ssm_parameter.vpc_id.value
project = var.project
environment = var.environment
sg_name = "user"
}


module "cart" {
source = "../Modules/SG/"
common_tags = var.common_tags
vpc_id = data.aws_ssm_parameter.vpc_id.value
project = var.project
environment = var.environment
sg_name = "cart"
}

module "shipping" {
source = "../Modules/SG/"
common_tags = var.common_tags
vpc_id = data.aws_ssm_parameter.vpc_id.value
project = var.project
environment = var.environment
sg_name = "shipping"
}


module "payment" {
source = "../Modules/SG/"
common_tags = var.common_tags
vpc_id = data.aws_ssm_parameter.vpc_id.value
project = var.project
environment = var.environment
sg_name = "payment"
}


module "dispatch" {
source = "../Modules/SG/"
common_tags = var.common_tags
vpc_id = data.aws_ssm_parameter.vpc_id.value
project = var.project
environment = var.environment
sg_name = "dispatch"
}

module "mysql" {
source = "../Modules/SG/"
common_tags = var.common_tags
vpc_id = data.aws_ssm_parameter.vpc_id.value
project = var.project
environment = var.environment
sg_name = "mysql"
}


module "rabbitmq" {
source = "../Modules/SG/"
common_tags = var.common_tags
vpc_id = data.aws_ssm_parameter.vpc_id.value
project = var.project
environment = var.environment
sg_name = "rabbitmq"
}

module "redis" {
source = "../Modules/SG/"
common_tags = var.common_tags
vpc_id = data.aws_ssm_parameter.vpc_id.value
project = var.project
environment = var.environment
sg_name = "redis"
}


module "web" {
source = "../Modules/SG/"
common_tags = var.common_tags
vpc_id = data.aws_ssm_parameter.vpc_id.value
project = var.project
environment = var.environment
sg_name = "web"
}

module "openvpn" {
source = "../Modules/SG/"
common_tags = var.common_tags
vpc_id = data.aws_ssm_parameter.default_vpc_id.value
project = var.project
environment = var.environment
sg_name = "openvpn"
}



###### openvpn ############
resource "aws_security_group_rule" "openvpn_home_inbound" {
  security_group_id  = module.openvpn.sg_id
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"] #ideally your home public IP address, but it frequently changes
}

resource "aws_security_group_rule" "openvpn_home_outbound" {
  type              = "egress"
  to_port           = 0
  protocol          = "-1"
  from_port         = 0
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.openvpn.sg_id

}


###### mongodb accepting connections form catalogue ############
resource "aws_security_group_rule" "mongodb_catalogue" {
  source_security_group_id = module.catalogue.sg_id
  type              = "ingress"
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp"
  security_group_id = module.mongodb.sg_id
  }


###### mongodb accepting connections form user ############
resource "aws_security_group_rule" "mongodb_user" {
  source_security_group_id = module.user.sg_id
  type              = "ingress"
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp"
  security_group_id = module.mongodb.sg_id
  }


###### redis accepting connections form user ############
resource "aws_security_group_rule" "redis_user" {
  source_security_group_id = module.user.sg_id
  type              = "ingress"
  from_port         = 6379
  to_port           = 6379
  protocol          = "tcp"
  security_group_id = module.redis.sg_id
  }

###### redis accepting connections form cart ############
resource "aws_security_group_rule" "redis_cart" {
  source_security_group_id = module.cart.sg_id
  type              = "ingress"
  from_port         = 6379
  to_port           = 6379
  protocol          = "tcp"
  security_group_id = module.redis.sg_id
  }

resource "aws_security_group_rule" "mysql_vpn" {
  source_security_group_id = module.openvpn.sg_id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.mysql.sg_id
}

resource "aws_security_group_rule" "mysql_shipping" {
  source_security_group_id = module.shipping.sg_id
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = module.mysql.sg_id
}


resource "aws_security_group_rule" "rabbitmq_vpn" {
  source_security_group_id = module.openvpn.sg_id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.rabbitmq.sg_id
}

resource "aws_security_group_rule" "rabbitmq_payment" {
  source_security_group_id = module.payment.sg_id
  type                     = "ingress"
  from_port                = 5672
  to_port                  = 5672
  protocol                 = "tcp"
  security_group_id        = module.rabbitmq.sg_id
}

resource "aws_security_group_rule" "catalogue_vpn" {
  source_security_group_id = module.openvpn.sg_id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.catalogue.sg_id
}

resource "aws_security_group_rule" "catalogue_web" {
  source_security_group_id = module.web.sg_id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.catalogue.sg_id
}

resource "aws_security_group_rule" "catalogue_cart" {
  source_security_group_id = module.cart.sg_id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.catalogue.sg_id
}

resource "aws_security_group_rule" "user_vpn" {
  source_security_group_id = module.openvpn.sg_id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.user.sg_id
}

resource "aws_security_group_rule" "user_web" {
  source_security_group_id = module.web.sg_id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.user.sg_id
}

resource "aws_security_group_rule" "user_payment" {
  source_security_group_id = module.payment.sg_id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.user.sg_id
}

resource "aws_security_group_rule" "cart_vpn" {
  source_security_group_id = module.openvpn.sg_id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.cart.sg_id
}

resource "aws_security_group_rule" "cart_web" {
  source_security_group_id = module.web.sg_id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.cart.sg_id
}

resource "aws_security_group_rule" "cart_shipping" {
  source_security_group_id = module.shipping.sg_id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.cart.sg_id
}

resource "aws_security_group_rule" "cart_payment" {
  source_security_group_id = module.payment.sg_id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.cart.sg_id
}

resource "aws_security_group_rule" "shipping_vpn" {
  source_security_group_id = module.openvpn.sg_id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.shipping.sg_id
}

resource "aws_security_group_rule" "shipping_web" {
  source_security_group_id = module.web.sg_id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.shipping.sg_id
}

resource "aws_security_group_rule" "payment_vpn" {
  source_security_group_id = module.openvpn.sg_id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.payment.sg_id
}

resource "aws_security_group_rule" "payment_web" {
  source_security_group_id = module.web.sg_id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.payment.sg_id
}

resource "aws_security_group_rule" "web_vpn" {
  source_security_group_id = module.openvpn.sg_id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.web.sg_id
}

resource "aws_security_group_rule" "web_internet" {
  cidr_blocks = ["0.0.0.0/0"]
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = module.web.sg_id
}