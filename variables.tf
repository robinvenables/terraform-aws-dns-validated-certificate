variable "dns_domain_name" {
  description = "The domain name for the Route 53 hosted zone."
  type        = string
}

variable "certificate_domain_name" {
  description = "The domain name for this certificate."
  type        = string
}

variable "certificate_san" {
  description = "The subject alternative name(s) for this certificate."
  type        = list(string)
}

variable "certificate_tags" {
  description = "Tags to apply to this certificate"
  type        = map
  default     = {
    "Created By" = "Terraform"
  }
}

variable "is_cloudfront_certificate" {
  description = "If true, the certificate will be created in North Virginia (us-east-1) for use with a CloudFront distribution"
  type        = bool
  default     = false
}
