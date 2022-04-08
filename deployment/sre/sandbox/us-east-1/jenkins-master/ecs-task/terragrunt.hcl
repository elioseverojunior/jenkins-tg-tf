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
  source = "../../../../../../apps//ecs-task/"

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
    ECS Task Definition Inputs
  */
  image = "jenkins/jenkins:latest"
  
  /*
    Tags Inputs
  */
  tags = merge(include.root.inputs.tags,
    {
      "ansible"  = false
      "deployer" = "elio.severo@passeidireto.com"
      "iac"      = "terraform"
      "owner"    = "SRE"
      "project"  = "ecs-task"
      "region"   = include.region.inputs.aws_region
      "repo"     = "https://github.com/PasseiDireto/terraform-jenkins-iac.git"
      "stack"    = include.environment.inputs.environment
      "tier"     = "infra"
      "vpc_id"   = include.environment.inputs.vpc_id
    }
  )

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
  all_cidr_blocks             = dependency.vpc.outputs.all_cidr_blocks
  all_subnets_map             = dependency.vpc.outputs.all_subnets_map
  all_subnets_ids             = dependency.vpc.outputs.all_subnets_ids
  private_cidr_blocks         = dependency.vpc.outputs.private_cidr_blocks
  private_subnets_map         = dependency.vpc.outputs.private_subnets_map
  private_subnets_ids         = dependency.vpc.outputs.private_subnets_ids
  public_cidr_blocks          = dependency.vpc.outputs.public_cidr_blocks
  public_subnets_map          = dependency.vpc.outputs.public_subnets_map
  public_subnets_ids          = dependency.vpc.outputs.public_subnets_ids
  selected_subnet_cidr_blocks = dependency.vpc.outputs.selected_subnets_cidr_blocks
  selected_subnets_map        = dependency.vpc.outputs.selected_subnets_map
  selected_subnets_ids        = dependency.vpc.outputs.selected_subnets_ids
  vpc_id                      = dependency.vpc.outputs.vpc_id
}
