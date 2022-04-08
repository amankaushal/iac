module "network" {
  source = "./modules/network"
  vpc_cidr_block = var.vpc_cidr_block
  vpc_dns_support = var.vpc_dns_support
  vpc_dns_hostnames = var.vpc_dns_hostnames
  sbn_public_ip = var.sbn_public_ip
  sbn_cidr_block = var.sbn_cidr_block
  rt_cidr_block = var.rt_cidr_block
  owner = var.owner
  env_type = var.env_type
  aws_region = var.aws_region
  nat_instance = module.compute.nat_instance
  nat_instance_id = module.compute.nat_instance_id
  app_instance = module.compute.app_instance
  app_instance_id = module.compute.app_instance_id
  upgrade = var.upgrade
  aws_region_az = var.aws_region_az
}

module "compute" {
  source = "./modules/compute"
  app_tag = var.app_tag
  ci_image_tag = var.ci_image_tag
  instance_ami = var.instance_ami
  nat_instance_ami = var.nat_instance_ami
  instance_type = var.instance_type
  instance_per_subnet = var.instance_per_subnet
  key_pair = var.key_pair
  root_device_type = var.root_device_type
  root_device_size = var.root_device_size
  sg_ingress_proto = var.sg_ingress_proto
  sg_ingress_ssh = var.sg_ingress_ssh
  sg_ingress_http = var.sg_ingress_http
  sg_ingress_app = var.sg_ingress_app
  sg_ingress_https = var.sg_ingress_https
  sg_ingress_nat_instance = var.sg_ingress_nat_instance
  sg_ingress_squid = var.sg_ingress_squid
  sg_egress_proto = var.sg_egress_proto
  sg_egress_all = var.sg_egress_all
  sg_egress_cidr_block = var.sg_egress_cidr_block
  vpc_id = module.network.vpc_id
  subnet_private = module.network.private_subnet
  subnet_public = module.network.public_subnet
  vpc_cidr_block = var.vpc_cidr_block
  owner = var.owner
  env_type = var.env_type
  aws_region = var.aws_region
  aws_region_az = var.aws_region_az
}

output "elb_endpoint" {
  value = module.compute.elb_endpoint
}