data "aws_route53_zone" "my_dns_zone" {
  name = var.dns_domain_name
}

resource "aws_route53_record" "validation_records" {
  for_each = {
    for dvo in var.is_cloudfront_certificate ? aws_acm_certificate.cloudfront_certificate[0].domain_validation_options : aws_acm_certificate.standard_certificate[0].domain_validation_options : dvo.domain_name => {
      name    = dvo.resource_record_name
      record  = dvo.resource_record_value
      type    = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.my_dns_zone.zone_id
}
