resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}

resource "aws_s3_bucket" "app" {
  bucket = "${var.developer_portal_application}-${random_string.suffix.id}"
}

resource "aws_s3_bucket_website_configuration" "app" {
  bucket = aws_s3_bucket.app.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_object" "app" {
  for_each     = local.files
  bucket       = aws_s3_bucket.app.id
  key          = replace(each.key, "/^www//", "") # Replace leading directory name
  content      = data.github_repository_file.app[each.key].content
  content_type = local.content_types[regex(".*\\.(.*)$", each.key)[0]] # Lookup content type based on file extension
}

data "aws_iam_policy_document" "origin_bucket_policy" {
  statement {
    sid    = "AllowCloudFrontServicePrincipalReadWrite"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    actions = [
      "s3:GetObject",
      "s3:PutObject",
    ]

    resources = [
      "${aws_s3_bucket.app.arn}/*",
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.s3_distribution.arn]
    }
  }
}

resource "aws_s3_bucket_policy" "app_policy" {
  bucket = aws_s3_bucket.app.bucket
  policy = data.aws_iam_policy_document.origin_bucket_policy.json

  depends_on = [aws_cloudfront_distribution.s3_distribution]
}

resource "aws_cloudfront_origin_access_control" "default" {
  name                              = "${var.developer_portal_application}-${random_string.suffix.id}"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

data "aws_cloudfront_cache_policy" "optimized" {
  name = "Managed-CachingOptimized"
}

resource "aws_cloudfront_response_headers_policy" "cors_expose_cache" {
  name = "${var.developer_portal_application}-${random_string.suffix.id}"

  cors_config {
    access_control_allow_credentials = false

    access_control_allow_headers {
      items = ["*"]
    }

    access_control_allow_origins {
      items = ["*"]
    }

    access_control_allow_methods {
      items = ["GET", "HEAD"]
    }

    access_control_expose_headers {
      items = ["X-Cache"]
    }

    origin_override = true
  }
}

# 2. Create a custom Cache Policy that forwards query strings
resource "aws_cloudfront_cache_policy" "cache_with_query_strings" {
  name        = "${var.developer_portal_application}-${random_string.suffix.id}"
  default_ttl = 86400
  max_ttl     = 31536000
  min_ttl     = 1

  parameters_in_cache_key_and_forwarded_to_origin {
    cookies_config {
      cookie_behavior = "none"
    }

    query_strings_config {
      query_string_behavior = "all"
    }

    headers_config {
      header_behavior = "none"
    }
  }
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name              = aws_s3_bucket.app.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.default.id
    origin_id                = var.developer_portal_application
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.developer_portal_application

    cache_policy_id            = aws_cloudfront_cache_policy.cache_with_query_strings.id
    response_headers_policy_id = aws_cloudfront_response_headers_policy.cors_expose_cache.id

    viewer_protocol_policy = var.redirect_to_https ? "redirect-to-https" : "allow-all"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

action "aws_cloudfront_create_invalidation" "full" {
  config {
    distribution_id = aws_cloudfront_distribution.s3_distribution.id
    paths           = ["/*"]
  }
}
