locals {
  prefix            = "friendly-prefix-name"
  ipv4_cidr         = "10.0.0.0/16"
  ipv4_cidr_newbits = 3
  subnets_number    = 2
  default_tags = {
    owner      = "ccscshq"
    created_by = "terraform"
  }
}
