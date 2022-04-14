resource "aws_route53_zone" "app" {
  name = "${var.domain}"
}

resource "aws_route53_record" "app" {
  allow_overwrite = true
  name            = "${var.domain}"
  ttl             = 172800
  type            = "NS"
  zone_id         = aws_route53_zone.app.zone_id

  records = [
    aws_route53_zone.app.name_servers[0],
    aws_route53_zone.app.name_servers[1],
    aws_route53_zone.app.name_servers[2],
    aws_route53_zone.app.name_servers[3],
  ]
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.app.zone_id
  name    = "www.${var.domain}"
  type    = "A"
  alias {
    name                   = "${aws_elb.elb.dns_name}"
    zone_id                = "${aws_elb.elb.zone_id}"
    evaluate_target_health = true
  }
}