resource "aws_subnet" "private_subnet" {
  count                   = length(var.aws_region_az)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr_block, 8, count.index)
  map_public_ip_on_launch = var.sbn_public_ip
  availability_zone       = "${var.aws_region_az[count.index]}"
 
  tags = {
    "Owner" = "${var.owner}"
    "Name"  = "${var.env_type}-${var.owner}-subnet-${count.index}"
    "Environment" = "${var.env_type}"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.sbn_cidr_block
  map_public_ip_on_launch = var.sbn_public_ip
  availability_zone       = var.aws_region_az[0]

  tags = {
    "Owner" = "${var.owner}"
    "Name"  = "${var.env_type}-${var.owner}-subnet-public"
    "Environment" = "${var.env_type}"
  }
}

output "private_subnet" {
  value = aws_subnet.private_subnet
}

output "public_subnet" {
  value = aws_subnet.public_subnet.id
}