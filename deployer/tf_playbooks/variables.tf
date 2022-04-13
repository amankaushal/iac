variable "aws_region" {}
variable "aws_region_az" {}
variable env_type {}
variable owner {}

variable app_tag {}
variable instance_per_subnet {}
variable instance_ami {}
variable instance_type {}
variable key_pair {}
variable root_device_type {}
variable root_device_size {}
variable sg_ingress_proto {}
variable sg_ingress_ssh {}
variable sg_ingress_app {}
variable sg_ingress_http {}
variable sg_egress_proto {}
variable sg_egress_all {}
variable sg_egress_cidr_block {}

variable vpc_cidr_block {}
variable vpc_dns_support {}
variable vpc_dns_hostnames {}
variable map_public_ip_on_launch {}
variable rt_cidr_block {}