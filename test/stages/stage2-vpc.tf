module "dev_vpc" {
  source = "./module"
  prefix_name=var.prefix_name
  internal_cidr=var.internal_cidr
  instance_tenancy=var.instance_tenancy
  provision = var.provision
}
