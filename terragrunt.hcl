skip                          = true
terragrunt_version_constraint = ">= 0.32"

locals {
  assume_role_name = "OrganizationAccountAccessRole"
  /*
  git_hash         = "${run_cmd("--terragrunt-quiet", "git", "rev-parse", "HEAD")}"
  git_repo_name    = "${run_cmd("--terragrunt-quiet", "/bin/bash", "-c", format("%s/scripts/git_repo_url.sh", get_parent_terragrunt_dir()))}"
  git_short_hash   = "${run_cmd("--terragrunt-quiet", "git", "rev-parse", "--short", "HEAD")}"
  */
  organization  = "Nutrien"
  tfenv         = format("%s/scripts/tfenv.sh", get_parent_terragrunt_dir())
  tfenv_version = "1.2.3"

  inputs = {
    tfenv         = local.tfenv
    tfenv_version = local.tfenv_version
  }
}

inputs = local.inputs

remote_state {
  backend = "s3"

  config = {
    encrypt = true
    bucket  = "nutrien-terraform-br-production"
    key     = "${path_relative_to_include()}/terraform.tfstate"
    region  = "us-east-1"
  }

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}
