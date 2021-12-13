variable "region"{
  type = string
  default ="ap-south-1" 
  description = "Please set the region where the resouces to be created "
}

variable "access_key"{
  type = string
}
variable "secret_key"{
  type = string
}

variable "prefix_name" {
  type        = string
  description = "Prefix to be added to the names of resources which are being provisioned"
  default     = "swe1"
}