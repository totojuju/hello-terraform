data "aws_route53_zone" "main" {
    name         = "myecslab.com"
    private_zone = false
}

resource "aws_route53_record" "hello" {
    zone_id = data.aws_route53_zone.main.zone_id
    name    = "hello.myecslab.com"
    type    = "A"

    alias {
        name                   = aws_lb.hello.dns_name
        zone_id                = aws_lb.hello.zone_id
        evaluate_target_health = true
    }
}