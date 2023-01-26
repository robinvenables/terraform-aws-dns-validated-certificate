resource "aws_acm_certificate" "cloudfront_certificate" {
  count = var.is_cloudfront_certificate ? 1 : 0

  provider = aws.cloudfront_certificate_region
  domain_name = var.certificate_domain_name
  subject_alternative_names = var.certificate_san
  validation_method = "DNS"
	lifecycle {
		create_before_destroy = true
	}
  tags = var.certificate_tags
}

resource "aws_acm_certificate" "standard_certificate" {
  count = var.is_cloudfront_certificate ? 0 : 1

  domain_name = var.certificate_domain_name
  subject_alternative_names = var.certificate_san
  validation_method = "DNS"
	lifecycle {
		create_before_destroy = true
	}
  tags = var.certificate_tags
}

resource "aws_acm_certificate_validation" "cloudfront_domain_validation" {
  count = var.is_cloudfront_certificate ? 1 : 0

  provider                = aws.cloudfront_certificate_region
  certificate_arn         = aws_acm_certificate.cloudfront_certificate[0].arn
  validation_record_fqdns = [for f in aws_route53_record.validation_records : f.fqdn]
}

resource "aws_acm_certificate_validation" "standard_domain_validation" {
  count = var.is_cloudfront_certificate ? 0 : 1

  certificate_arn         = aws_acm_certificate.standard_certificate[0].arn
  validation_record_fqdns = [for f in aws_route53_record.validation_records : f.fqdn]
}
