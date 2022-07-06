locals {
  runtime      = "nickel"
  runtime_long = "nickel"
}

inputs = {
  environment                  = local.runtime
  environment_long             = local.runtime_long
  runtime                      = local.runtime
  runtime_long                 = local.runtime_long
  s3_remote_bucket             = "br-nicket-us-east-1-terraform-state-store"
  s3_accesslogging_bucket_name = "nutrien-shared-services-nickel-s3-access-logs"
  vpc_id                       = "vpc-0443d8f80bb165013"
}
