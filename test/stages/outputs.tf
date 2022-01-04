output "vpc_id" {
    depends_on = [module.dev_vpc]
    value = module.dev_vpc.vpc_id
}

output "vpc" {
    depends_on = [module.dev_vpc]
    value = module.dev_vpc.vpc
}

output "default_security_group_id" {
    depends_on = [module.dev_vpc]
    value       = module.dev_vpc.default_security_group_id
    description = "The id of the default security group."
}

output "default_network_acl_id" {
    depends_on = [module.dev_vpc]
    value       = module.dev_vpc.default_network_acl_id
    description = "The id of the default security group."
}

