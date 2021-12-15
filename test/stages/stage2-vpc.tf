module "dev_vpc" {
  source = "./module"
  prefix_name=var.prefix_name
  internal_cidr=var.internal_cidr
  instance_tenancy=var.instance_tenancy
  vpc_id = "vpc-0c5f482e03ec5be11"
  provision = var.provision
}
