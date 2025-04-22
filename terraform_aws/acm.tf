resource "aws_acm_certificate" "stg_menta_cert" {
  domain_name       = var.stg_menta_domain
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = "stg_menta_cert"
  }
}
resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = aws_acm_certificate.stg_menta_cert.arn
  validation_record_fqdns = [aws_route53_record.stg_menta_validation.fqdn]
}



