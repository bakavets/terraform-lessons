terraform {
  source = "${include.root.locals.source_url}//modules/kms?ref=${include.root.locals.source_version}"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  aws_iam_service_linked_role_autoscaling = false
}
