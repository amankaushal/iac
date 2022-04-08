
resource "aws_security_group" "sg" {
  name        = "${var.owner}-sg"
  description = "Allow inbound traffic via SSH"
  vpc_id      = var.vpc_id
 
  ingress = [{
    description      = "Private subnet ssh"
    protocol         = var.sg_ingress_proto
    from_port        = var.sg_ingress_ssh
    to_port          = var.sg_ingress_ssh
    cidr_blocks      = ["${var.vpc_cidr_block}"]
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = false
  },
  {
    description      = "Http port 8080 for all"
    protocol         = var.sg_ingress_proto
    from_port        = var.sg_ingress_app
    to_port          = var.sg_ingress_app
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = false
  },
  {
    description      = "Http port 80 for all"
    protocol         = var.sg_ingress_proto
    from_port        = var.sg_ingress_http
    to_port          = var.sg_ingress_http
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = false
  }
  ]
 
  egress = [{
    description      = "All traffic"
    protocol         = var.sg_egress_proto
    from_port        = var.sg_egress_all
    to_port          = var.sg_egress_all
    cidr_blocks      = [var.sg_egress_cidr_block]
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = false
 
  }]
 
  tags = {
    "Owner" = "${var.owner}"
    "Name"  = "${var.env_type}-${var.owner}-sg"
    "Environment" = "${var.env_type}"
  }
}