## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 6.69.1 |
| <a name="requirement_github"></a> [github](#requirement\_github) | ~> 6.13.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.9.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.69.1 |
| <a name="provider_github"></a> [github](#provider\_github) | 6.13.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.9.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudfront_cache_policy.cache_with_query_strings](https://registry.terraform.io/providers/hashicorp/aws/6.69.1/docs/resources/cloudfront_cache_policy) | resource |
| [aws_cloudfront_distribution.s3_distribution](https://registry.terraform.io/providers/hashicorp/aws/6.69.1/docs/resources/cloudfront_distribution) | resource |
| [aws_cloudfront_origin_access_control.default](https://registry.terraform.io/providers/hashicorp/aws/6.69.1/docs/resources/cloudfront_origin_access_control) | resource |
| [aws_cloudfront_response_headers_policy.cors_expose_cache](https://registry.terraform.io/providers/hashicorp/aws/6.69.1/docs/resources/cloudfront_response_headers_policy) | resource |
| [aws_s3_bucket.app](https://registry.terraform.io/providers/hashicorp/aws/6.69.1/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_policy.app_policy](https://registry.terraform.io/providers/hashicorp/aws/6.69.1/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_website_configuration.app](https://registry.terraform.io/providers/hashicorp/aws/6.69.1/docs/resources/s3_bucket_website_configuration) | resource |
| [aws_s3_object.app](https://registry.terraform.io/providers/hashicorp/aws/6.69.1/docs/resources/s3_object) | resource |
| [random_string.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [aws_cloudfront_cache_policy.optimized](https://registry.terraform.io/providers/hashicorp/aws/6.69.1/docs/data-sources/cloudfront_cache_policy) | data source |
| [aws_iam_policy_document.origin_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/6.69.1/docs/data-sources/iam_policy_document) | data source |
| [github_branch.app](https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/branch) | data source |
| [github_repository.app](https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/repository) | data source |
| [github_repository_file.app](https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/repository_file) | data source |
| [github_tree.app](https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/tree) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_developer_portal_add_on"></a> [developer\_portal\_add\_on](#input\_developer\_portal\_add\_on) | The name of the add-on. Automatically supplied by Terraform Developer Portal | `string` | n/a | yes |
| <a name="input_developer_portal_add_on_definition"></a> [developer\_portal\_add\_on\_definition](#input\_developer\_portal\_add\_on\_definition) | The name of the add-on definition used to create this add-on. Automatically supplied by Terraform Developer Portal | `string` | n/a | yes |
| <a name="input_developer_portal_application"></a> [developer\_portal\_application](#input\_developer\_portal\_application) | Name of the application. Automatically supplied by Terraform Developer Portal | `string` | n/a | yes |
| <a name="input_gh_org"></a> [gh\_org](#input\_gh\_org) | GitHub organization to deploy the application to | `string` | n/a | yes |
| <a name="input_redirect_to_https"></a> [redirect\_to\_https](#input\_redirect\_to\_https) | If true, automatically redirect all traffic to use TLS encryption | `bool` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region to deploy the application | `string` | `"us-east-2"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_website_endpoint"></a> [website\_endpoint](#output\_website\_endpoint) | CloudFront URL to access the S3 deployment |
