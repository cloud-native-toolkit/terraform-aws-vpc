output "vpc" {
  value = data.aws_vpc.vpc
  
}

output "vpc_name" {
  value = local.vpc_name
}

output "vpc_id" {
  value = local.vpc_id
  description = "The id for the vpc network"
}

output "vpc_arn" {
  value       = local.arn
  description = "The arn of the vpc"
}

output "default_network_acl_id" {
  value  = local.acl_id
  #value  = ""
  description = "The id for the default network acl"
}

output "default_security_group_id" {
  value       = local.security_group_id
  description = "The id of the default security group."
}

output "default_security_group_arn" {
  value       = local.security_group_arn
  description = "The arn of the default security group."
}