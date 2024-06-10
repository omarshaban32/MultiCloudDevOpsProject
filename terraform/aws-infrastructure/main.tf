module "vpc" {
  source = "./vpc"
  vpc_cidr = var.vpc_cidr
}

module "subnets" {
  source = "./subnets"
  vpc_id = module.vpc.vpc_id
  public_subnet_cidrs = var.public_subnet_cidrs
}

module "security_groups" {
  source = "./security-groups"
  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source = "./ec2"
  vpc_id = module.vpc.vpc_id
  public_subnet_id = element(module.subnets.public_subnet_ids, 0)
  security_group_id = module.security_groups.security_group_id
  instance_type = var.instance_type
  ami = var.ami
}

