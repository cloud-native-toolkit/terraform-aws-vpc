//Remove later
output "new-vpc-out" {
  value = aws_vpc.vpc
}

output "existing_vpc_output" {
  value = data.aws_vpc.vpc
}
output "local-acl-id" {
  value = local.acl_id[0]
}

output "vpc-id" {
  value = data.aws_vpc.vpc.id
}
