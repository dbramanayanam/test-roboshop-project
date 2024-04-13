variable "vpc_cidr_block" {
  #type        = string
  default     = "10.0.0.0/16"
  description = "vpc cidr pbock"
}

variable "enable_dns_hostnames" {
  type        = bool
  default     = "true"
}

variable "common_tags" {
  #type        = string
  default     = {}
}

variable "vpc_tags" {
  #type        = string
  default     = {}
  
}
variable "igw_tags" {

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

variable "subnet_tags" {
  default     = {}
}


variable "public_cidr" {
  type        = list
  validation {
    condition     = length(var.public_cidr) == 2
    error_message = "user should enter two cidr blocks for two regions"
  }
}

variable "private_cidr" {
  type        = list
  validation {
    condition     = length(var.private_cidr) == 2
    error_message = "user should enter two cidr blocks for two regions"
  }
}

variable "database_cidr" {
  type        = list
  validation {
    condition     = length(var.database_cidr) == 2
    error_message = "user should enter two cidr blocks for two regions"
  }
}

variable "natgw_tags" {
  default     = {}

}

variable "private_rt_tags" {
  default     = {}
}
 variable "public_rt_tags" {
   default     = {}
 }
 
 variable "database_rt_tags" {

   default     = {}

 }
 
 variable "is_peering_required" {
   #type = "bool"
   default  = "true"
 }
 variable "provide_vpc_id" {
   default     = ""
 }
 
 variable "vpc_peering_tags" {
   default     = {}
 }
 
