variable "resource_group" {
  type        = string
  description = "Name of the resource group "
  default     = "software-everywhere"
}
variable "name" {
  type        = string
  description = "The name of the vpc instance"
  default     = "" #"swe-ind-vpc"
}
variable "vpc_id" {
  type        = string
  description = "The id of the vpc instance"
  default     = ""
}

variable "internal_cidr" {
  type        = string
  description = "The cidr range of the internal network"
  default     = "10.0.0.0/16"
}

variable "external_cidr" {
  type        = string
  description = "The cidr range of the external network"
  default     = "0.0.0.0/0"
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

variable "prefix_name" {
  type        = string
  description = "Prefix to be added to the names of resources which are being provisioned"
  default     = "swe"
}

variable "enable_dns_support" {
  type        = string
  description = "default is true. [true, false]]"
  default     = true
}

variable "enable_dns_hostnames" {
  type        = string
  description = "default is false. [true, false]]"
  default     = false
}

