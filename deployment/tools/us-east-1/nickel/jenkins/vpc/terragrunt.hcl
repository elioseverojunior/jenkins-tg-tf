include "root" {
  path           = find_in_parent_folders()
  expose         = true
  merge_strategy = "deep"
}

include "common" {
  path           = find_in_parent_folders("common.hcl")
  expose         = true
  merge_strategy = "deep"
}

include "region" {
  path           = find_in_parent_folders("region.hcl")
  expose         = true
  merge_strategy = "deep"
}

include "environment" {
  path           = find_in_parent_folders("environment.hcl")
  expose         = true
  merge_strategy = "deep"
}

include "application" {
  path           = find_in_parent_folders("application.hcl")
  expose         = true
  merge_strategy = "deep"
}

locals {
  workspace_name = format("vpc-%s-%s", include.common.inputs.country, include.environment.inputs.runtime)
  inputs = merge(
    include.root.inputs,
    include.common.inputs,
    include.region.inputs,
    include.environment.inputs,
    include.application.inputs,
    {
      iac_source = "https://github.com/Agrium/jenkins-ecs"
      pillar     = "platform"
      tags_override = {
        iac_workspace = local.workspace_name
      }
    },
  )
  tfenv_version = "latest"
  remote_state = merge(include.root.remote_state,
    {
      backend = include.root.remote_state.backend
      config = merge(
        include.root.remote_state.config,
        {
          bucket                    = include.environment.inputs.s3_remote_bucket,
          region                    = include.region.inputs.aws_region,
          accesslogging_bucket_name = include.environment.inputs.s3_accesslogging_bucket_name
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

  before_hook "tfenv" {
    commands = ["init", "plan", "apply", "import", "push", "refresh", "validate", "destroy"]
    execute  = ["bash", "-c", "${include.root.inputs.tfenv} ${local.tfenv_version}"]
  }
}

generate "tfvars" {
  path              = "terragrunt.auto.tfvars.json"
  if_exists         = "overwrite"
  disable_signature = true
  contents          = jsonencode(local.inputs)
}

inputs = local.inputs
