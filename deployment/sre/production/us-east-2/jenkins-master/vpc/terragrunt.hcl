include "root" {
  path           = find_in_parent_folders()
  expose         = true
  merge_strategy = "deep"
}

include "team" {
  path           = find_in_parent_folders("team.hcl")
  expose         = true
  merge_strategy = "deep"
}

include "environment" {
  path           = find_in_parent_folders("environment.hcl")
  expose         = true
  merge_strategy = "deep"
}

include "region" {
  path           = find_in_parent_folders("region.hcl")
  expose         = true
  merge_strategy = "deep"
}

include "application" {
  path           = find_in_parent_folders("application.hcl")
  expose         = true
  merge_strategy = "deep"
}

locals {
  tfenv_version = "latest"
  remote_state = merge(include.root.remote_state,
    {
      backend = include.root.remote_state.backend
      config = merge(
        include.root.remote_state.config,
        {
          bucket = include.environment.inputs.s3_remote_bucket,
          region = include.region.inputs.aws_region,
        }
      )

      generate = {
        path      = "backend.tf"
        if_exists = "overwrite_terragrunt"
      }
    }
  )
}

remote_state = local.remote_state

terraform {
  source = "../../../../../../apps//vpc/"

  before_hook "tfenv_install" {
    commands = ["init", "plan", "apply", "destroy", "validate"]
    execute  = ["tfenv", "install", local.tfenv_version]
  }

  before_hook "tfenv_use" {
    commands = ["init", "plan", "apply", "destroy", "validate"]
    execute  = ["tfenv", "use", local.tfenv_version]
  }
}

inputs = {
  /*
    Tags Inputs
  */
  tags = merge(include.root.inputs.tags,
    {
      "ansible"  = false
      "deployer" = "elio.severo@passeidireto.com"
      "iac"      = "terraform"
      "owner"    = "SRE"
      "project"  = "Security Groups"
      "region"   = include.region.inputs.aws_region
      "repo"     = "https://github.com/PasseiDireto/terraform-jenkins-iac.git"
      "stack"    = include.environment.inputs.environment
      "tier"     = "infra"
      "vpc_id"   = include.environment.inputs.vpc_id
    }
  )
}
