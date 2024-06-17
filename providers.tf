provider "aws" {
  region = local.region
  default_tags {
    tags = {
      owner     = "sandesh.lama"
      silo      = "intern"
      terraform = "true"
    }
  }
}
