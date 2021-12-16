output "vpc_id" {
    value = module.dev_vpc.vpc_id
}

output "vpc" {
    value = module.dev_vpc.vpc
}

output "default_security_group_id" {
  value       = module.dev_vpc.default_security_group_id
  description = "The id of the default security group."
}

output "default_network_acl_id" {
  value       = module.dev_vpc.default_network_acl_id
  description = "The id of the default security group."
}

