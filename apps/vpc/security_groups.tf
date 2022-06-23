resource "aws_security_group" "lb_to_tg_sg" {
  name                   = format("%s-lb-to-tg-sg", local.prefix_name_lower)
  description            = "Security Group for Load Balancer"
  revoke_rules_on_delete = true
  vpc_id                 = var.vpc_id

  ingress {
    description = "HTTP 80 Port"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = length(local.selected_cidr_blocks) > 0 ? local.selected_cidr_blocks : local.all_cidr_blocks
  }

  ingress {
    description = "HTTPS 443 Port"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = length(local.selected_cidr_blocks) > 0 ? local.selected_cidr_blocks : local.all_cidr_blocks
  }

  ingress {
    description = "HTTP 8080 Port"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = length(local.selected_cidr_blocks) > 0 ? local.selected_cidr_blocks : local.all_cidr_blocks
  }

  egress {
    description = "HTTP 80 Port"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = length(local.selected_cidr_blocks) > 0 ? local.selected_cidr_blocks : local.all_cidr_blocks
  }

  egress {
    description = "HTTPS 443 Port"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = length(local.selected_cidr_blocks) > 0 ? local.selected_cidr_blocks : local.all_cidr_blocks
  }

  egress {
    description = "HTTP 8080 Port"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = length(local.selected_cidr_blocks) > 0 ? local.selected_cidr_blocks : local.all_cidr_blocks
  }

  egress {
    description = "HTTP 8080 Port"
    from_port   = 32768
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = length(local.selected_cidr_blocks) > 0 ? local.selected_cidr_blocks : local.all_cidr_blocks
  }

  tags = merge(var.tags, { Name = format("%s-lb-to-tg-sg", local.prefix_name_lower) })
}

resource "aws_security_group" "lb_sg" {
  name                   = format("%s-lb-sg", local.prefix_name_lower)
  description            = "Security Group for Load Balancer"
  revoke_rules_on_delete = true
  vpc_id                 = var.vpc_id

  ingress {
    description = "HTTP 80 Port"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = length(local.selected_cidr_blocks) > 0 ? local.selected_cidr_blocks : local.all_cidr_blocks
  }

  ingress {
    description = "HTTP 443 Port"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = length(local.selected_cidr_blocks) > 0 ? local.selected_cidr_blocks : local.all_cidr_blocks
  }

  ingress {
    description     = "TCP from 32768 to 65535 Port Range"
    from_port       = 32768
    to_port         = 65535
    protocol        = "tcp"
    security_groups = [aws_security_group.lb_to_tg_sg.id]
  }

  /* egress {
    description = "Enabling Outbound to everywhere"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = length(local.selected_cidr_blocks) > 0 ? local.selected_cidr_blocks : local.all_cidr_blocks
  } */

  tags = merge(var.tags, { Name = format("%s-lb-sg", local.prefix_name_lower) })
}

resource "aws_security_group" "jenkins_sg" {
  name                   = format("%s-sg", local.prefix_name_lower)
  description            = "Security Group for Jenkins Master"
  revoke_rules_on_delete = true
  vpc_id                 = var.vpc_id

  ingress {
    description = "SSH 22 Port"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = length(local.selected_cidr_blocks) > 0 ? local.selected_cidr_blocks : local.all_cidr_blocks
  }

  ingress {
    description     = "TCP from 32768 to 65535"
    from_port       = 32768
    to_port         = 65535
    protocol        = "tcp"
    security_groups = [aws_security_group.lb_sg.id, aws_security_group.lb_to_tg_sg.id]
    cidr_blocks     = length(local.selected_cidr_blocks) > 0 ? local.selected_cidr_blocks : local.all_cidr_blocks
  }

  ingress {
    description     = "HTTP 8080 Port"
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.lb_sg.id, aws_security_group.lb_to_tg_sg.id]
  }

  egress {
    description = "Enabling Outbound to 22 in VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = length(local.selected_cidr_blocks) > 0 ? local.selected_cidr_blocks : local.all_cidr_blocks
  }

  egress {
    description = "Enabling Outbound to everywhere"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = length(local.selected_cidr_blocks) > 0 ? local.selected_cidr_blocks : local.all_cidr_blocks
  }

  tags = merge(var.tags, { Name = format("%s-sg", local.prefix_name_lower) })
}

resource "aws_security_group" "jenkins_agent_sg" {
  name                   = format("%s-agent-sg", local.prefix_name_lower)
  description            = "Security Group for Jenkins agents"
  revoke_rules_on_delete = true
  vpc_id                 = var.vpc_id

  ingress {
    description = "Container Ports 49153 to 65535 Port Range"
    from_port   = 49153
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = length(local.selected_cidr_blocks) > 0 ? local.selected_cidr_blocks : local.all_cidr_blocks
  }

  ingress {
    description     = "Enabling Inbound Security Group Rule to ${var.jnlp_port} Port"
    from_port       = var.jnlp_port
    to_port         = var.jnlp_port
    protocol        = "tcp"
    security_groups = [aws_security_group.jenkins_sg.id, aws_security_group.lb_sg.id, aws_security_group.lb_to_tg_sg.id]
  }

  egress {
    description = "Enabling Outbound to everywhere"
    from_port   = var.jnlp_port
    to_port     = var.jnlp_port
    protocol    = "tcp"
    cidr_blocks = length(local.selected_cidr_blocks) > 0 ? local.selected_cidr_blocks : local.all_cidr_blocks
  }

  tags = merge(var.tags, { Name = format("%s-agent-sg", local.prefix_name_lower) })
}

resource "aws_security_group" "efs_sg" {
  name        = format("%s-efs-sg", local.prefix_name_lower)
  description = "Enable EFS access via port 2049"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Enabling Inbound from Port 2049"
    from_port       = 2049
    to_port         = 2049
    protocol        = "tcp"
    security_groups = [aws_security_group.jenkins_sg.id, aws_security_group.jenkins_agent_sg.id]
    cidr_blocks     = length(local.selected_cidr_blocks) > 0 ? local.selected_cidr_blocks : local.all_cidr_blocks
  }

  egress {
    description = "Enabling Outbound to Port 2049"
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = length(local.selected_cidr_blocks) > 0 ? local.selected_cidr_blocks : local.all_cidr_blocks
  }

  tags = merge(var.tags, { Name = format("%s-efs-sg", local.prefix_name_lower) })
}
