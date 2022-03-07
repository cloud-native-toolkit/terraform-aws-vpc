module "dev_vpc" {
  source = "./module"

  provision        = var.provision && var.cloud_provider == "aws"? true : false
  
  
  /* Input params required to provision new VPC */
  name_prefix      = var.name_prefix
  internal_cidr    = var.internal_cidr
  instance_tenancy = var.instance_tenancy
  resource_group_name = var.resource_group_name
  #enabled          = var.enabled
}

# resource null_resource print_enabled {
#   provisioner "local-exec" {
#     command = "echo -n '${module.dev_vpc.enabled}' > .enabled"
#   }
# }
