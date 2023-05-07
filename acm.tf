resource "aws_acm_certificate" "this" {
  domain_name               = var.hosted_zone_domain
  subject_alternative_names = [var.api_domain]
  validation_method         = "DNS"
}

resource "aws_acm_certificate_validation" "this" {
  certificate_arn         = aws_acm_certificate.this.arn
  validation_record_fqdns = [for record in aws_route53_record.acm : record.fqdn]
}
