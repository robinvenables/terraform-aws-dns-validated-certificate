# terraform-aws-dns-validated-certificate
A Terraform module to create an AWS ACM certificate validated by DNS (Route 53).

## Description
This module creates an AWS ACM certificate, using DNS to validate domain ownership.

## Inputs
1. dns_domain_name (string) - The domain name for the Route 53 hosted zone
2. certificate_domain_name (string) - The domain name for this certificate
3. certificate_san (list(string)) - The subject alternative name(s) for this certificate
4. certificate_tags (map) - Tags to apply to this certificate
5. is_cloudfront_certificate (bool) - If true, the certificate will be created in North Virginia (us-east-1) for use with a CloudFront distribution

## Usage
```hcl
module "get_certificate" {
  source = "git@github.com:robinvenables/terraform-aws-dns-validated-certificate"

  dns_domain_name         = "example.com"
  certificate_domain_name = "example.com"
  certificate_san         = ["www.example.com"]
  certificate_tags = {
    Name    = "example-website-certificate"
  }

  is_cloudfront_certificate = true
}
```

## Outputs
1. The ARN of the newly generated certificate
