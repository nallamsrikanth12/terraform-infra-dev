module "vpc" {
    source = "git::https://github.com/nallamsrikanth12/terraform-vpc-module-new.git"
    project_name = var.project_name
    public_subnet_cidrs = var.public_subnet_cidrs
    environment = var.environment
    private_subnet_cidrs = var.private_subnet_cidrs
    database_subnet_cidrs = var.database_subnet_cidrs
    is_peering_required = var.is_peering_required



}