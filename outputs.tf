output "website_endpoint" {
  value = "https://${aws_cloudfront_distribution.s3_distribution.domain_name}"
}
