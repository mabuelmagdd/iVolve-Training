module "vpc" {
  source  = "./vpc-module"

  vpc_cidr    = var.vpc_cidr
  subnet_cidrs = var.subnet_cidrs
}

module "ec2_1" {
  depends_on = [ module.vpc ]
  source       = "./ec2-module"
  subnet_id    = module.vpc.public_subnet_ids[0]
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_id        = module.vpc.vpc_id
}

module "ec2_2" {
  depends_on = [ module.vpc ]
  source       = "./ec2-module"
  subnet_id    = module.vpc.public_subnet_ids[1]
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_id        = module.vpc.vpc_id
}

