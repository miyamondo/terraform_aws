resource "aws_route53_record" "stg_menta" {
  zone_id = var.stg_menta_hostzone_id
  name    = var.stg_menta_domain
  type    = "A"
  alias {
    name                   = aws_lb.stg_menta_alb.dns_name
    zone_id                = aws_lb.stg_menta_alb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "stg_menta_validation" {
  name    = tolist(aws_acm_certificate.stg_menta_cert.domain_validation_options)[0].resource_record_name
  type    = tolist(aws_acm_certificate.stg_menta_cert.domain_validation_options)[0].resource_record_type
  records = [tolist(aws_acm_certificate.stg_menta_cert.domain_validation_options)[0].resource_record_value]
  ttl     = 300
  zone_id = var.stg_menta_hostzone_id
}

