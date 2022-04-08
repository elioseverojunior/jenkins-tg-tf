inputs = {
  access_cidr_blocks = ["172.30.0.0/16"]
  environment        = "prod"
  environment_short  = "prod"
  s3_remote_bucket   = "pd-sre-production"
  selected_subnets = [
    "subnet-60edab09",
    "subnet-13d85468",
    "subnet-0ba17246",
  ]
  vpc_id = "vpc-498cfc20"
}
