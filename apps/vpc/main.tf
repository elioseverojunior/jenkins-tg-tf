data "aws_vpc" "this" {
  state = "available"
  id    = var.vpc_id
}

data "aws_security_groups" "default_security_groups" {
  filter {
    name   = "group-name"
    values = ["*default*"]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.this.id]
  }
}

data "aws_subnets" "all" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.this.id]
  }
}

data "aws_subnet" "all" {
  for_each = toset(data.aws_subnets.all.ids)
  id       = each.value
}

/* Public */
data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.this.id]
  }
  tags = var.public_subnet_tag_filter
}

data "aws_subnet" "public" {
  for_each = toset(data.aws_subnets.public.ids)
  id       = each.value
}

/* Private */
data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.this.id]
  }

  tags = var.all_private_subnet_tag_filter
}

data "aws_subnet" "private" {
  for_each = toset(data.aws_subnets.private.ids)
  id       = each.value
}

/* Private By Filters */
data "aws_subnets" "private_by_filter" {
  tags = var.all_private_subnet_tag_filter
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.this.id]
  }

  filter {
    name   = "cidr-block"
    values = var.cidr_block_filter
  }
}

data "aws_subnet" "private_by_filter" {
  for_each = toset(data.aws_subnets.private_by_filter.ids)
  id       = each.value
}
