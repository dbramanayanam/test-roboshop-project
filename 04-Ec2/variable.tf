variable "common_tags" {
  #type        = map
  default     = {
     project = "roboshop"
     environment = "dev"
     terraform = "yes"

  }
}

variable "vpc_tags" {
  default     = {}
  
}

variable "ec2_tags" {
  default     = {}
  
}



variable "project" {
  type        = string
  default     = "roboshop"
}

variable "environment" {
  type        = string
  default     = "dev"
}

variable "instance_type" {
  type        = string
  default     = "t3.small"
}

variable "zone_name" {
  type        = string
  default     = "dineshdevops.online"
}
