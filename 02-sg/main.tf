module "db" {
  source = "../sg-module"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  sg_description = "allow sg for db"
  sg_name =  "db"
  project_name = var.project_name
  environment =  var.environment
  common_tags = var.common_tags

}

module "backend" {
  source = "../sg-module"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  sg_description = "allow sg for backend"
  sg_name =  "backend"
  project_name = var.project_name
  environment =  var.environment
  common_tags = var.common_tags

}

module "frontend" {
  source = "../sg-module"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  sg_description = "allow sg for frontend"
  sg_name =  "frontend"
  project_name = var.project_name
  environment =  var.environment
  common_tags = var.common_tags

}

module "bastion" {
  source = "../sg-module"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  sg_description = "allow sg for bastion"
  sg_name =  "bastion"
  project_name = var.project_name
  environment =  var.environment
  common_tags = var.common_tags

}

module "app_alb" {
  source = "../sg-module"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  sg_description = "allow sg for alb"
  sg_name =  "app_alb"
  project_name = var.project_name
  environment =  var.environment
  common_tags = var.common_tags

}

module "vpn" {
  source = "../sg-module"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  sg_description = "allow sg for vpn"
  sg_name =  "vpn"
  project_name = var.project_name
  environment =  var.environment
  common_tags = var.common_tags
  ingress_rule = var.vpn_rules


}

module "web_alb" {
  source = "../sg-module"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  sg_description = "allow sg for vpn"
  sg_name =  "web_alb"
  project_name = var.project_name
  environment =  var.environment
  common_tags = var.common_tags

}

# web_alb security group rules

resource "aws_security_group_rule" "web_alb_public" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id =  module.web_alb.sg_id
}

resource "aws_security_group_rule" "web_alb_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id =  module.web_alb.sg_id
}



# db security rule

resource "aws_security_group_rule" "db_backend" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  security_group_id =  module.db.sg_id
  source_security_group_id = module.backend.sg_id
}

resource "aws_security_group_rule" "db_bastion" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  security_group_id =  module.db.sg_id
  source_security_group_id = module.bastion.sg_id
}


resource "aws_security_group_rule" "db_vpn" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  security_group_id =  module.db.sg_id
  source_security_group_id = module.vpn.sg_id
}


# app_alb  security group rule

resource "aws_security_group_rule" "app_alb_vpn" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id =  module.app_alb.sg_id
  source_security_group_id = module.vpn.sg_id
}

resource "aws_security_group_rule" "app_alb_frontend" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id =  module.app_alb.sg_id
  source_security_group_id = module.frontend.sg_id
}

resource "aws_security_group_rule" "app_alb_bastion" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id =  module.app_alb.sg_id
  source_security_group_id = module.bastion.sg_id
}


# backend security group rules

resource "aws_security_group_rule" "backend_app_alb" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  security_group_id =  module.backend.sg_id
  source_security_group_id = module.app_alb.sg_id
}

resource "aws_security_group_rule" "backend_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id =  module.backend.sg_id
  source_security_group_id = module.bastion.sg_id
}

resource "aws_security_group_rule" "backend_vpn_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id =  module.backend.sg_id
  source_security_group_id = module.vpn.sg_id
}

resource "aws_security_group_rule" "backend_vpn_http" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  security_group_id =  module.backend.sg_id
  source_security_group_id = module.vpn.sg_id
}

# frontend security rules

resource "aws_security_group_rule" "frontend_web_alb" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id =  module.frontend.sg_id
  source_security_group_id = module.web_alb.sg_id
}

resource "aws_security_group_rule" "frontend_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id =  module.frontend.sg_id
  source_security_group_id = module.bastion.sg_id
}

resource "aws_security_group_rule" "frontend_vpn" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id =  module.frontend.sg_id
  source_security_group_id = module.vpn.sg_id
}


# bastion sg rules

resource "aws_security_group_rule" "bastion_public" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id =  module.bastion.sg_id
  cidr_blocks = ["0.0.0.0/0"]
}


resource "aws_security_group_rule" "backend_defaulvpc" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id =  module.backend.sg_id
  cidr_blocks = ["172.31.0.0/16"]
}







