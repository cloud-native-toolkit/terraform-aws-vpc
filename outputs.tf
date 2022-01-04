output "vpc" {
  value = data.aws_vpc.vpc
  
}
output "vpc_id" {
  value = local.vpc_id
  description = "The id for the vpc network"
}

output "vpc_arn" {
  value       = data.aws_vpc.vpc.arn
  description = "The arn of the vpc"
}

output "default_network_acl_id" {
  //value = concat(aws_default_network_acl.default.*.id, [""])[0]
  value  = local.acl_id[0]
  description = "The id for the default network acl"
}

output "default_security_group_id" {
  value       = data.aws_security_group.default_aws_security_group.id
  description = "The id of the default security group."
}

# output "default_security_group_arn" {
#   value       = data.aws_security_group.default_aws_security_group.arn
#   description = "The arn of the default security group."
# }





