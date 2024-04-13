module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  name = "${var.project}-${var.environment}-openvpn"
  instance_type          = var.instance_type
  ami = data.aws_ami.devops-practice.id
  vpc_security_group_ids = [data.aws_ssm_parameter.openvpn_sg_id.value]
  subnet_id              = data.aws_subnet.selected.id 
  user_data = file("openvpn.sh")
  tags = merge(
    var.common_tags,
    var.vpn_tags,
    {
      Name = "${var.project}-${var.environment}-vpn"
    }
  )
}