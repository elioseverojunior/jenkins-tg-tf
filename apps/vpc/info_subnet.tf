module "all_subnets" {
  source           = "./modules//subnets/"
  subnets          = data.aws_subnet.all
  selected_subnets = var.selected_subnets
}

module "private_subnets" {
  source           = "./modules//subnets/"
  subnets          = data.aws_subnet.all_private
  selected_subnets = var.selected_subnets
}

module "public_subnets" {
  source           = "./modules//subnets/"
  subnets          = data.aws_subnet.public
  selected_subnets = var.selected_subnets
}

module "subnets" {
  source           = "./modules//subnets/"
  subnets          = data.aws_subnet.all
  selected_subnets = var.selected_subnets
}
