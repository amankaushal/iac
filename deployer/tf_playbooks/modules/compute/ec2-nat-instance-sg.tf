resource "aws_security_group" "nat_instance" {
  name        = "${var.env_type}-${var.owner}-nat_instance-sg"
  description = "Allow inbound traffic via SSH"
  vpc_id      = var.vpc_id
 
  ingress = [{
    description      = "My public IP"
    protocol         = var.sg_ingress_proto
    from_port        = var.sg_ingress_ssh
    to_port          = var.sg_ingress_ssh
    cidr_blocks      = ["${chomp(data.http.myip.body)}/32", "${var.vpc_cidr_block}"]
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = false
  },
  {
    description      = "http for internal network"
    protocol         = var.sg_ingress_proto
    from_port        = var.sg_ingress_http
    to_port          = var.sg_ingress_http
    cidr_blocks      = ["${var.vpc_cidr_block}"]
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = false
  },
  {                                                                                 
    description      = "http for internal network"                                  
    protocol         = var.sg_ingress_proto                                         
    from_port        = var.sg_ingress_https                                        
    to_port          = var.sg_ingress_https                                         
    cidr_blocks      = ["${var.vpc_cidr_block}"]                                    
    ipv6_cidr_blocks = []                                                           
    prefix_list_ids  = []                                                           
    security_groups  = []                                                           
    self             = false                                                        
  }, 
  {
    description      = "My public IP"
    protocol         = var.sg_ingress_proto
    from_port        = var.sg_ingress_nat_instance
    to_port          = var.sg_ingress_nat_instance
    cidr_blocks      = ["${chomp(data.http.myip.body)}/32"]
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = false
  }]
 
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
    "Name"  = "${var.env_type}-${var.owner}-nat_instance-sg"
    "Environment" = "${var.env_type}"
  }
}