resource "aws_acm_certificate" "hello" {
    domain_name       = "hello.myecslab.com"
    validation_method = "DNS"

    lifecycle {
        create_before_destroy = true
    }

    tags = {
        Name = "hello-myecslab-cert"
    }
}

resource "aws_route53_record" "hello_cert_validation" {
    for_each = {
        for dvo in aws_acm_certificate.hello.domain_validation_options : dvo.domain_name => {
            name   = dvo.resource_record_name
            record = dvo.resource_record_value
            type   = dvo.resource_record_type
        }
    }

    allow_overwrite = true
    zone_id         = data.aws_route53_zone.main.zone_id
    name            = each.value.name
    type            = each.value.type
    records         = [each.value.record]
    ttl             = 60
}

resource "aws_acm_certificate_validation" "hello" {
    certificate_arn         = aws_acm_certificate.hello.arn
    validation_record_fqdns = [for r in aws_route53_record.hello_cert_validation : r.fqdn]
}
