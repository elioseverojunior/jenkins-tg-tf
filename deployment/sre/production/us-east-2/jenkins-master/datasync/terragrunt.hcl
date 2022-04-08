locals {
  tf_version = "latest"
}

include {
  path = find_in_parent_folders()
}

include "region" {
  path = find_in_parent_folders("region.hcl")
}

terraform {
  source = "git::https://github.com/PasseiDireto/terraform-aws-iac-jenkins.git//datasync?ref=v1.0.0"

  before_hook "tfenv_install" {
    commands = ["init", "plan", "apply", "destroy", "validate"]
    execute  = ["tfenv", "install", local.tf_version]
  }

  before_hook "tfenv_use" {
    commands = ["init", "plan", "apply", "destroy", "validate"]
    execute  = ["tfenv", "use", local.tf_version]
  }
}

inputs = {
  application         = "jenkins-datasync"
  file_system_id      = "fs-78a43d00"
  vpc_id              = "vpc-498cfc20"
  bucket_name         = "pd-sre-backups"
  cron                = "0 1 * * ? *"
  cloudwatch_loglevel = "BASIC"
  tags = {
    "Name"        = "jenkins-datasync"
    "ansible"  = "false"
    "deployer" = "elio.severo@passeidireto.com"
    "iac"      = "terraform"
    "owner"    = "SRE"
    "project"  = "jenkins-datasync"
    "region"   = "us-east-2"
    "repo"     = "https://github.com/PasseiDireto/terraform-jenkins-iac.git"
    "stack"    = "production"
    "tier"     = "infra"
  }
  subnet_ids = [
    "subnet-907b39f9", #us-east-2a
    "subnet-689b1213", #us-east-2b
    "subnet-08508d45", #us-east-2c
  ]
  security_groups = [
    "sg-0adde2da6e0c854c3"
  ]
}