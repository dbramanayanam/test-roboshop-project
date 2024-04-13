variable "common_tags" {
  #type        = string
  default     = {
     project = "roboshop"
     environment = "dev"
     terraform = "yes"
  }
}
variable "project" {
  default     = "roboshop"
}

variable "environment" {
  default     = "dev"
}

variable "sg_name" {
  type        = string
  default     = ""
  description = "description"
}
