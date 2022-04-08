variable "env_type" {} 
variable "owner" {}
variable "app_tag" {}
variable "ci_image_tag" {}
variable "aws_region_az" {}
variable "aws_region" {}
variable "subnet_private" {}
variable "instance_per_subnet" {}
variable "subnet_public" {}
variable vpc_id {}
variable vpc_cidr_block {}
variable "instance_ami" {}
variable "nat_instance_ami" {}
variable "instance_type" {}
variable "key_pair" {}
variable "root_device_type" {}
variable "root_device_size" {}
variable "sg_ingress_proto" {}
variable "sg_ingress_ssh" {}
variable "sg_ingress_http" {}
variable "sg_ingress_app" {}
variable "sg_ingress_https" {}
variable "sg_ingress_nat_instance" {}
variable "sg_ingress_squid" {}    
variable "sg_egress_proto" {}
variable "sg_egress_all" {}
variable "sg_egress_cidr_block" {}