data "aws_ssm_parameter" "db_sg_id" {
  name =  "/${var.project_name}/${var.environment}/db_sg_id"
}


data "aws_ssm_parameter" "aws_db_subnet_group_name" {
  name =  "/${var.project_name}/${var.environment}/aws_db_subnet_group_name"
}

