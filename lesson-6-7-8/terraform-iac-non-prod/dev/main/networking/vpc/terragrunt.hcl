terraform {
  source = "${include.root.locals.source_url}//modules/networking/vpc?ref=${include.root.locals.source_version}"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  cidr                   = "10.20.0.0"
  single_nat_gateway     = true
  one_nat_gateway_per_az = false
}
