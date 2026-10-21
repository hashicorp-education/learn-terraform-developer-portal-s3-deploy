variable "gh_org" {
  description = "GitHub organization to deploy the application to"
  type        = string
  nullable    = false
}

variable "region" {
  description = "Region to deploy the application"
  type        = string
  nullable    = false
  default     = "us-east-2"
}

variable "developer_portal_application" {
  description = "Name of the application. Automatically supplied by Terraform Developer Portal"
  type        = string
}

variable "developer_portal_add_on" {
  description = "The name of the add-on. Automatically supplied by Terraform Developer Portal"
  type        = string
}

variable "developer_portal_add_on_definition" {
  description = "The name of the add-on definition used to create this add-on. Automatically supplied by Terraform Developer Portal"
  type        = string
}

variable "redirect_to_https" {
  description = "If true, automatically redirect all traffic to use TLS encryption"
  type        = bool
  nullable    = false
}
