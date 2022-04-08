include {
  path = find_in_parent_folders()
}

include "environment" {
  path = find_in_parent_folders("environment.hcl")
}

include "region" {
  path = find_in_parent_folders("region.hcl")
}

terraform {
  source = "/Users/elio/Development/elioseverojunior/jenkins/jenkins-ecs-terraform/apps//ecr/"

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
  ecr_name = "jenkins"
  tags = {
    "Name"        = "jenkins-ecr-registry"
    "ansible"  = "false"
    "deployer" = "elio.severo@passeidireto.com"
    "iac"      = "terraform"
    "owner"    = "SRE"
    "project"  = "jenkins-ecr-registry"
    "region"   = "us-east-1"
    "repo"     = "https://github.com/PasseiDireto/terraform-jenkins-iac.git"
    "stack"    = include.environment.inputs.environment
    "tier"     = "infra"
    "vpc_id"   = "vpc-0aa97d8dc6991a18d"
  }
}