skip                          = true
terragrunt_version_constraint = ">= 0.32"

remote_state {
  backend = "s3"

  config = {
    encrypt = true
    bucket  = "pd-sre-production"
    key     = "${path_relative_to_include()}/terraform.tfstate"
    region  = "us-east-2"
  }

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

inputs = {
  tags = {
    "ansible"  = false
    "deployer" = "elio.severo@passeidireto.com"
    "iac"      = "terraform"
    "owner"    = "SRE"
    "project"  = "TBD"
    "region"   = "TBD"
    "repo"     = "https://github.com/PasseiDireto/terraform-jenkins-iac.git"
    "stack"    = "TBD"
    "tier"     = "infra"
    "vpc_id"   = "TBD"
  }
  tfenv = "${get_parent_terragrunt_dir()}/scripts/tfenv.sh"
}
