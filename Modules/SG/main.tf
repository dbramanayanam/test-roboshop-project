resource "aws_security_group" "sg_group" {
  name        = var.sg_name
  description = var.sg_description
  vpc_id      = var.vpc_id

  tags = merge(
    var.common_tags,
    var.sg_tags,
    {
        Name = local.name
    }
  ) 
}
