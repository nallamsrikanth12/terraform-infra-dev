variable "project_name" {
  
}

variable "environment" {
  
}

variable "common_tags" {
  
}

variable "sg_name" {
  
}


variable "sg_description" {
  
}

variable "vpc_id" {
  
}

variable "egress_rule" {
    default = [
        {
            from_port = 0
            to_port = 0
            protocol = "-1"
            cidr_blocks = ["0.0.0.0/0"]
        }
    ]
  
}


variable "ingress_rule" {
    default = []
  
}