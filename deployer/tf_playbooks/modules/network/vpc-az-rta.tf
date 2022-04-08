resource "null_resource" "rt_sn_assoc" {
  triggers = {
    always_run = "${timestamp()}"
  }
  count          = length(var.aws_region_az)
  provisioner "local-exec" {
    command = <<EOT
      aws ec2 associate-route-table --region ${var.aws_region} --subnet-id ${aws_subnet.private_subnet[count.index].id} --route-table ${aws_route_table.rt.id}
    EOT
  }
}

resource "aws_route_table_association" "rt_sbn_asso_public" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public.id
}

resource "null_resource" "previous" {}