dependencies {
  paths = ["../vpc", "../efs", "../ecs"]
}

dependency "vpc" {
  config_path = "../vpc"
}

dependency "efs" {
  config_path = "../efs"
}

dependency "ecs" {
  config_path = "../ecs"
}

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
  source = "../../../../../../apps//ecs-task/"

  before_hook "tfenv" {
    commands = ["init", "plan", "apply", "import", "push", "refresh", "validate", "destroy"]
    execute  = ["bash", "-c", "${include.root.inputs.tfenv} ${local.tfenv_version}"]
  }
}

inputs = {
  /*
    ECS inputs
  */
  ecs_cluster_id             = dependency.ecs.outputs.ecs_cluster_id
  loadbalancer_arn           = dependency.ecs.outputs.loadbalancer_arn
  jenkins_role_arn           = dependency.ecs.outputs.jenkins_role_arn
  jenkins_execution_role_arn = dependency.ecs.outputs.jenkins_execution_role_arn

  /*
    EFS inputs
  */
  efs_file_system_id  = dependency.efs.outputs.efs_id
  efs_access_point_id = dependency.efs.outputs.efs_access_point_id

  /*
    Security Groups Inputs
  */
  security_group_efs_id           = dependency.vpc.outputs.security_group_efs_id
  security_group_jenkins_agent_id = dependency.vpc.outputs.security_group_jenkins_agent_id
  security_group_jenkins_id       = dependency.vpc.outputs.security_group_jenkins_id
  security_group_loadbalancer_id  = dependency.vpc.outputs.security_group_loadbalancer_id

  /*
    VPC Inputs
  */
  cidr_blocks_all             = dependency.vpc.outputs.cidr_blocks_all
  subnets_all_map             = dependency.vpc.outputs.subnets_all_map
  subnets_all_ids             = dependency.vpc.outputs.subnets_all_ids
  cidr_blocks_private         = dependency.vpc.outputs.cidr_blocks_private
  subnets_private_map         = dependency.vpc.outputs.subnets_private_map
  subnets_private_ids         = dependency.vpc.outputs.subnets_private_ids
  cidr_blocks_public          = dependency.vpc.outputs.cidr_blocks_public
  subnets_public_map          = dependency.vpc.outputs.subnets_public_map
  subnets_public_ids          = dependency.vpc.outputs.subnets_public_ids
  selected_subnet_cidr_blocks = dependency.vpc.outputs.selected_subnets_cidr_blocks
  selected_subnets_map        = dependency.vpc.outputs.selected_subnets_map
  selected_subnets_ids        = dependency.vpc.outputs.selected_subnets_ids
  vpc_id                      = dependency.vpc.outputs.vpc_id
}
