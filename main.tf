locals {
 vpc-count-index =""
 acl_name =""


}

# Create a VPC
resource "aws_vpc" "ind-vpc" {
  count = var.provision ? 1 : 0
  cidr_block           = var.internal_cidr
  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = true
  enable_dns_hostnames = false
  tags = var.resource-tags
}

//Remove later
output "new-vpc-out" {
  value = aws_vpc.ind-vpc
}

data aws_vpc "ind-vpc" {
  id = var.provision ? aws_vpc.ind-vpc[0].id : var.vpc-id
}
output existing_vpc_output {
  value = data.aws_vpc.ind-vpc
}
data "aws_network_acls" "ind-vpc-network-acls" {
  vpc_id = var.provision ? aws_vpc.ind-vpc[0].id : var.vpc-id
  //vpc_id ="vpc-00124f171b3a21879"
  filter {
    name   = "default"
    values = ["true"]
  }
}

output ind-vpc-acl-output {
  value = data.aws_network_acls.ind-vpc-network-acls
}


/* resource "aws_default_network_acl" "default" {
  #for_each = data.aws_network_acls.ind-vpc-network-acls.ids
  //acl_name = each.key
  /* default_network_acl_id = (data.aws_network_acls.ind-vpc-network-acls.ids)[0]
  #data.aws_network_acls.ind-vpc-network-acls.default_network_acl_id
  # if no rules defined, deny all traffic in this ACL
  egress {          #allow_internal_egress
    protocol   = -1 # -1 'all' protocol
    rule_no    = 100
    action     = "allow"
    cidr_block = data.aws_vpc.ind-vpc.cidr_block
    from_port  = 0
    to_port    = 0
  }

  ingress {         #allow_internal_ingress
    protocol   = -1 #-1 'all' protocol 
    rule_no    = 100
    action     = "allow"
    cidr_block = data.aws_vpc.ind-vpc.cidr_block
    from_port  = 0
    to_port    = 0
  }

  ingress {            #deny_external_ssh
    protocol   = "tcp" #-1 'all' protocol 
    rule_no    = 200
    action     = "deny"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }

  ingress {            #deny_external_rdp
    protocol   = "tcp" # -1 'all' protocol
    rule_no    = 300
    action     = "deny"
    cidr_block = "0.0.0.0/0"
    from_port  = 3389
    to_port    = 3389
  }

  ingress {         #deny_external_ingress
    protocol   = -1 # -1 'all' protocol
    rule_no    = 400
    action     = "deny"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = var.resource-tags
  

}
*/


#====#
# resource "aws_security_group" "base" {
#   name        = "allow_tls"
#   description = "Allow TLS inbound traffic"
#   vpc_id      = aws_vpc.aws_vpc.ind-vpc.id

# }
resource "aws_default_security_group" "default_security_group" {
  tags = var.resource-tags
  vpc_id      = data.aws_vpc.ind-vpc.id
}

resource "aws_security_group_rule" "default_inbound_ping" {
  type              = "ingress"
  from_port         = 8
  to_port           = 8
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_default_security_group.default_security_group.id
  
}

resource "aws_security_group_rule" "default_inbound_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  #security_group_id = aws_vpc.ind-vpc.default_security_group_id
  security_group_id = aws_default_security_group.default_security_group.id
  
}

# resource "aws_security_group_rule" "cse_dns_1" { 
#   //Check to which group the rule to be added 
#   //Check In IBM VPC the  remote address is attached to the rule remote    = "161.26.0.10"
#   type              = "egress"
#   from_port         = 53
#   to_port           = 53
#   protocol          = "udp"
#   cidr_blocks       = "161.0.0.0/10"
#   security_group_id = aws_vpc.ind-vpc.default_security_group_id
# }

# resource "aws_security_group_rule" "cse_dns_2" { 
#   //Check to which group the rule to be added ???
#   //Check In IBM VPC the  remote address is attached to the rule remote    = "161.26.0.11"
#   type              = "egress"
#   from_port         = 53
#   to_port           = 53
#   protocol          = "udp"
#   cidr_blocks       = ["0.0.0.0/0"]
#   security_group_id = aws_vpc.ind-vpc.default_security_group_id
# }

//Check below private dns rules which are configured in IBM VPC

# resource "aws_security_group_rule" "private_dns_1" { 
#   //Check to which group the rule to be added ???
#   //Check In IBM VPC the  remote address is attached to the rule remote    = "161.26.0.7"
#   type              = "egress"
#   from_port         = 53
#   to_port           = 53
#   protocol          = "udp"
#   # cidr_blocks       = ["0.0.0.0/0"]
#   # security_group_id = data.aws_security_group.default_security_group_id
# }

# resource "aws_security_group_rule" "private_dns_2" { 
#   //Check to which group the rule to be added ???
#   //Check In IBM VPC the  remote address is attached to the rule remote    = "161.26.0.8"
#   type              = "egress"
#   from_port         = 53
#   to_port           = 53
#   protocol          = "udp"
#   #cidr_blocks       = ["0.0.0.0/0"] 
#   #security_group_id = data.aws_security_group.default_security_group_id
# }

