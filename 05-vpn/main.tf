resource "aws_key_pair" "vpn" {
  key_name   = "openvpn"
   public_key = file("D:/.ssh/openvpn.pub")
  # Use double backslashes for Windows paths
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name                    = local.resource_name
  key_name                = aws_key_pair.vpn.key_name
  instance_type           = "t2.micro"
  vpc_security_group_ids  = [data.aws_ssm_parameter.vpn_sg_id.value]
  subnet_id               = local.public_subnet_id
  ami                     = data.aws_ami.ami_info.id

  tags = merge(
    var.common_tags,
    {
      Terraform   = "true"
      Environment = "dev"
      Name        = local.resource_name
    }
  )
}