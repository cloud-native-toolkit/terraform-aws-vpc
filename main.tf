locals {
  vpc-count-index = ""
  acl_id          = tolist(data.aws_network_acls.default-vpc-network-acls.ids)
  vpc_name        = var.name != "" ? var.name : "${var.prefix_name}-vpc"
  vpc_id = var.provision ? aws_vpc.vpc[0].id : var.vpc_id  
}

# Create a VPC
resource "aws_vpc" "vpc" {
  count                = var.provision ? 1 : 0
  cidr_block           = var.internal_cidr
  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  tags = {
    Name = local.vpc_name
  }
}

data "aws_vpc" "vpc" {
  id = local.vpc_id
}

data "aws_network_acls" "default-vpc-network-acls" {
  vpc_id = data.aws_vpc.vpc.id
  filter {
    name   = "default"
    values = ["true"]
  }
}

resource "aws_default_network_acl" "default" {
  count = var.provision ? 1 : 0
  default_network_acl_id = local.acl_id[0]
  # if no rules defined, deny all traffic in this ACL
  egress {          #allow_internal_egress
    protocol   = -1 # -1 'all' protocol
    rule_no    = 100
    action     = "allow"
    cidr_block = data.aws_vpc.vpc.cidr_block
    from_port  = 0
    to_port    = 0
  }

  ingress {         #allow_internal_ingress
    protocol   = -1 #-1 'all' protocol 
    rule_no    = 200
    action     = "allow"
    cidr_block = data.aws_vpc.vpc.cidr_block
    from_port  = 0
    to_port    = 0
  }

  ingress {            #deny_external_ssh
    protocol   = "tcp" #-1 'all' protocol 
    rule_no    = 300
    action     = "deny"
    cidr_block = var.external_cidr //"0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }

  ingress {            #deny_external_rdp
    protocol   = "tcp" # -1 'all' protocol
    rule_no    = 400
    action     = "deny"
    cidr_block = var.external_cidr //"0.0.0.0/0"
    from_port  = 3389
    to_port    = 3389
  }
  tags = {
    Name = "${local.vpc_name}-default_acl"
  }
}

resource "aws_default_security_group" "default_security_group" {
  count                = var.provision ? 1 : 0
  vpc_id = local.vpc_id
  tags = {
    Name = "${local.vpc_name}-default_sg"
  }
}

resource "aws_security_group_rule" "default_inbound_ping" {
  count                = var.provision ? 1 : 0
  type              = "ingress"
  from_port         = 8
  to_port           = 8
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = element(aws_default_security_group.default_security_group.*, 0).id
}

resource "aws_security_group_rule" "default_inbound_http" {
  count                = var.provision ? 1 : 0
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = element(aws_default_security_group.default_security_group.*, 0).id

}

data "aws_security_group" "default_aws_security_group" {
  vpc_id = local.vpc_id
  filter {
    name   = "group-name"
    values = ["default"]
  }
}