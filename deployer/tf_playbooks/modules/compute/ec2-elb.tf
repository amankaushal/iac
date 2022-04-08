resource "aws_elb" "elb" {
  security_groups = [aws_security_group.sg.id]
  subnets = var.subnet_private.*.id
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 5
    target = "HTTP:8080/hello"
  }
  listener {
    lb_port = 80
    lb_protocol = "http"
    instance_port = "8080"
    instance_protocol = "http"
  }
  tags = {
    "Owner" = "${var.owner}"
    "Name"  = "${var.env_type}-${var.owner}-elb"
    "Environment" = "${var.env_type}"
  }
  instances = "${aws_instance.instance.*.id}"
}

output "elb_endpoint" {
  value = ["${aws_elb.elb.dns_name}"]
}