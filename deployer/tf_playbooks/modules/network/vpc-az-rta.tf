resource "aws_route_table_association" "rt_sbn_asso_public" {
  count          = length(var.aws_region_az)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public.id
}