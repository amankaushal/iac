resource "aws_instance" "app" {
  count                       = var.instance_per_subnet * length(var.aws_region_az)
  ami                         = var.instance_ami
  instance_type               = var.instance_type
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.sg.id]
  subnet_id                   = var.public_subnet[count.index % length(var.aws_region_az)].id
  key_name                    = aws_key_pair.kp.key_name
 
  root_block_device {
    delete_on_termination = true
    encrypted             = false
    volume_size           = var.root_device_size
    volume_type           = var.root_device_type
  }

	user_data = <<EOF
#!/bin/bash
apt-get update
apt-get install -y docker.io
EOF

  tags = {
    "Owner" = "${var.owner}"
    "Name"  = "${var.env_type}-${var.aws_region_az[count.index]}-instance-${count.index}"
    "Environment" = "${var.env_type}"
    "KeepInstanceRunning" = "false"
  }
}

resource "time_sleep" "wait_120_seconds" {
  create_duration = "120s"
  depends_on = [aws_instance.app]
}

resource "null_resource" "setup_app" {
  count                       = var.instance_per_subnet * length(var.aws_region_az)
  triggers = {
    always_run = "${timestamp()}"
  }
  provisioner "local-exec" {
    command = <<EOT
    chmod 400 myKey.pem;cd ../ansible_playbooks;ansible-playbook \
       -i "${aws_instance.app[count.index].public_ip}," \
       -e "app_tag=${var.app_tag}" \
       -e "suchname=${var.aws_region_az[count.index]}-${var.app_tag}" \
       -e "ansible_ssh_user=ubuntu" \
       -e "ansible_ssh_private_key_file=../tf_playbooks/myKey.pem" \
       setup_app.yml
    EOT
  }
  depends_on = [time_sleep.wait_120_seconds]
}

output "private_ip" {
  value = ["${aws_instance.app.*.private_ip}"]
}

output app_instance_id {
  value = ["${aws_instance.app.*.id}"]
}

output app_instance {
  value = aws_instance.app
}