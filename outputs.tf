output "website_endpoint" {
  description = "CloudFront URL to access the S3 deployment"
  value       = "https://${aws_cloudfront_distribution.s3_distribution.domain_name}"
}
