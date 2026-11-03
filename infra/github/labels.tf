locals {
  default_labels = {
    "bug"              = { color = "d73a4a", description = "Something isn't working" }
    "documentation"    = { color = "0075ca", description = "Improvements or additions to documentation" }
    "duplicate"        = { color = "cfd3d7", description = "This issue or pull request already exists" }
    "enhancement"      = { color = "a2eeef", description = "New feature or request" }
    "good first issue" = { color = "7057ff", description = "Good for newcomers" }
    "help wanted"      = { color = "008672", description = "Extra attention is needed" }
    "invalid"          = { color = "e4e669", description = "This doesn't seem right" }
    "question"         = { color = "d876e3", description = "Further information is requested" }
    "wontfix"          = { color = "ffffff", description = "This will not be worked on" }
  }
  labels = merge(local.default_labels, {
    "autorelease: pending" = { color = "ededed", description = "Release PR awaiting merge" }
    "autorelease: tagged"  = { color = "ededed", description = "Release PR tagged by release-please" }
    "dependencies"         = { color = "0366d6", description = "Pull requests that update a dependency file" }
  })
}
resource "github_issue_label" "labels" {
  for_each    = local.labels
  repository  = github_repository.this.name
  name        = each.key
  color       = each.value.color
  description = each.value.description
}
import {
  for_each = local.default_labels
  to       = github_issue_label.labels[each.key]
  id       = "${var.repository_name}:${each.key}"
}
