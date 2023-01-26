output "certificate_arn" {
  description = "The ARN of the new certificate generated."
  value       = var.is_cloudfront_certificate ? aws_acm_certificate.cloudfront_certificate[0].arn : aws_acm_certificate.standard_certificate[0].arn
}
