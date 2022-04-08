resource "aws_instance" "nat_instance" {
  ami                         = var.instance_ami
  instance_type               = var.instance_type
  associate_public_ip_address = true
  source_dest_check           = false
  vpc_security_group_ids      = [aws_security_group.nat_instance.id]
  subnet_id                   = var.subnet_public
  key_name                    = aws_key_pair.kp.key_name

  root_block_device {
    delete_on_termination = true
    encrypted             = false
    volume_size           = var.root_device_size
    volume_type           = var.root_device_type
  }

	user_data = <<EOF
#!/bin/bash
sudo sysctl -q -w net.ipv4.ip_forward=1
sudo iptables -A FORWARD -i eth0 -j ACCEPT
sudo iptables -t nat -A POSTROUTING -s ${var.vpc_cidr_block} -j MASQUERADE
EOF

  tags = {
    "Owner" = "${var.owner}"
    "Name"  = "${var.env_type}-${var.owner}-nat_instance"
    "Environment" = "${var.env_type}"
    "KeepInstanceRunning" = "false"
  }
}

resource "null_resource" "previous" {}

resource "time_sleep" "wait_300_seconds" {
  create_duration = "300s"
  depends_on = [aws_instance.nat_instance]
}

output nat_instance_id {
  value = aws_instance.nat_instance.id
}

output nat_instance {
  value = aws_instance.nat_instance
}

output "public_ip" {
  value = ["${aws_instance.nat_instance.public_ip}"]
}