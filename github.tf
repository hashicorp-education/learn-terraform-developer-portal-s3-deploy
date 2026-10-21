data "github_repository" "app" {
  name = var.developer_portal_application
}

data "github_branch" "app" {
  repository = data.github_repository.app.name
  branch     = data.github_repository.app.default_branch
}

data "github_tree" "app" {
  recursive  = true
  repository = data.github_repository.app.name
  tree_sha   = data.github_branch.app.sha
}

locals {
  # Only deploy the files in the www/ directory of the supplied repository
  files = {
    for file in data.github_tree.app.entries :
    file.path => file
    if file.type == "blob" && startswith(file.path, "www/")
  }

  # Lookup map for content types
  content_types = {
    "html" = "text/html",
    "css"  = "text/css",
    "js"   = "application/x-javascript"
  }
}

data "github_repository_file" "app" {
  for_each = local.files

  repository = data.github_repository.app.name
  branch     = data.github_repository.app.default_branch
  file       = each.key
}
