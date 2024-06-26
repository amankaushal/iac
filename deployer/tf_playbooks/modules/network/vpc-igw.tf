resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
 
  tags = {
    "Owner" = "${var.owner}"
    "Name"  = "${var.env_type}-${var.owner}-igw"
    "Environment" = "${var.env_type}"
  }
}