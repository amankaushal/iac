resource "aws_subnet" "public_subnet" {
  count                   = length(var.aws_region_az)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr_block, 8, count.index)
  map_public_ip_on_launch = var.map_public_ip_on_launch
  availability_zone       = "${var.aws_region_az[count.index]}"
 
  tags = {
    "Owner" = "${var.owner}"
    "Name"  = "${var.env_type}-${var.owner}-public-subnet-${count.index}"
    "Environment" = "${var.env_type}"
  }
}

output "public_subnet" {
  value = aws_subnet.public_subnet
}