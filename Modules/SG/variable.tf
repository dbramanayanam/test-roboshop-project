variable "project" {

}

variable "environment" {

}


variable "common_tags" {
  default     = {}
}

variable "sg_tags" {
  default     = {}
  
}

variable "sg_name" {
}

variable "sg_description" {
  #type        = "string"
  default     = "mongodb_sg_rules"
}

variable "vpc_id" {
  
}
