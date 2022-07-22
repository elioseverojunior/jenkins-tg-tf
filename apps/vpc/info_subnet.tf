module "subnets_all" {
  source           = "./modules//subnets/"
  subnets          = data.aws_subnet.all
  selected_subnets = var.selected_subnets
}

module "subnets_private" {
  source           = "./modules//subnets/"
  subnets          = data.aws_subnet.private
  selected_subnets = var.selected_subnets
}

module "subnets_public" {
  source           = "./modules//subnets/"
  subnets          = data.aws_subnet.public
  selected_subnets = var.selected_subnets
}

module "subnets" {
  source           = "./modules//subnets/"
  subnets          = data.aws_subnet.all
  selected_subnets = var.selected_subnets
}
