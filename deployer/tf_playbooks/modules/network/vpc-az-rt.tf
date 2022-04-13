resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.rt_cidr_block
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    "Owner" = "${var.owner}"
    "Name"  = "${var.env_type}-${var.owner}-rt-public"
    "Environment" = "${var.env_type}"
  }
}

output "routes" {
  value = aws_route_table.public
}