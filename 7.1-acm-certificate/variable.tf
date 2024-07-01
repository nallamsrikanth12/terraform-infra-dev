variable "project_name" {
    default = "expense"
  
}

variable "environment" {
    default = "dev"
  
}

variable "common_tags" {
    default = {
        project  = "expense"
        environment = "dev"
        terraform = "true"
        Component = "expense"
    }
  
}

variable "zone_name" {
    default = "srikantheswar.online"
  
}

variable "zone_id" {
    default = "Z0516899942YGG0KGEH4"
  
}