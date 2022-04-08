resource "aws_instance" "instance" {
  count                       = var.instance_per_subnet * length(var.aws_region_az)
  ami                         = var.instance_ami
  instance_type               = var.instance_type
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.sg.id]
  subnet_id                   = var.subnet_private[count.index % length(var.aws_region_az)].id
  key_name                    = aws_key_pair.kp.key_name
 
  root_block_device {
    delete_on_termination = true
    encrypted             = false
    volume_size           = var.root_device_size
    volume_type           = var.root_device_type
  }

	user_data = <<EOF
Content-Type: multipart/mixed; boundary="//"
MIME-Version: 1.0

--//
Content-Type: text/cloud-config; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="cloud-config.txt"

#cloud-config
cloud_final_modules:
- [scripts-user, always]

--//
Content-Type: text/x-shellscript; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="userdata.txt"

#!/bin/bash
apt-get update
apt-get install -y docker.io
docker pull ${var.app_tag}
docker run --env suchname=${var.aws_region_az[count.index % length(var.aws_region_az)]} -it -d --net=host ${var.app_tag}
EOF

  tags = {
    "Owner" = "${var.owner}"
    "Name"  = "${var.env_type}-${var.owner}-instance-${count.index}"
    "Environment" = "${var.env_type}"
    "KeepInstanceRunning" = "false"
  }
  depends_on = [aws_instance.nat_instance]
}

output "private_ip" {
  value = ["${aws_instance.instance.*.private_ip}"]
}

output app_instance_id {
  value = ["${aws_instance.instance.*.id}"]
}

output app_instance {
  value = aws_instance.instance
}