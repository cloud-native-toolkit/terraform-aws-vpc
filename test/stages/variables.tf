variable "region"{
  type = string
  default ="ap-south-1"
}

variable "access_key"{
  type = string
}
variable "secret_key"{
  type = string
}

variable "resource-group" {
 type = string
 description = "Name of the resource group "
 default= "software-everywhere"
}

variable "resource-tags" {
  type=map
  default = {
    Name = "ind-vpc"
    //project="software-everywhere" //added at the provider level
  }
}
variable "name" {
  type        = string
  description = "The name of the vpc instance"
  default     = ""#"swe-ind-vpc"
}
variable "vpc-id" {
  type        = string
  description = "The id of the vpc instance"
  default     = ""
}

variable "internal_cidr" {
  type        = string
  description = "The cidr range of the internal network"
  default     = "10.0.0.0/16"
}

variable "provision" {
  type        = bool
  description = "Flag indicating that the instance should be provisioned. If false then an existing instance will be looked up"
  default     = true
}

variable "instance_tenancy" {
  type        = string
  description = "Instance is shared / dedicated, etc. #[default, dedicated, host]"
  default     = "default"
}

variable "prefix-name" {
  type        = string
  description = "Prefix to be added to the names of resources which are being provisioned"
  default     = "swe"
}
