data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami*amazon-ecs-optimized"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["amazon", "self"]
}

data "template_file" "cluster_user_data" {
  template = file("${path.module}/user-data/cluster.sh")
  vars = {
    cluster_name        = local.prefix_name_lower
    efs_file_system_id  = var.efs_file_system_id
    efs_access_point_id = var.efs_access_point_id
    efs_mount_point     = var.efs_mount_point
  }
}

resource "aws_launch_configuration" "lc" {
  name                 = format("%s-lc", local.prefix_name_lower)
  image_id             = data.aws_ami.amazon_linux.id
  instance_type        = var.instance_type
  key_name             = data.aws_key_pair.key_pair.key_name
  iam_instance_profile = aws_iam_instance_profile.ecs_service_role.name
  security_groups      = [var.security_group_jenkins_id]
  user_data            = data.template_file.cluster_user_data.rendered
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg" {
  name                      = format("%s-asg", local.prefix_name_lower)
  launch_configuration      = aws_launch_configuration.lc.name
  min_size                  = 1
  max_size                  = 1
  desired_capacity          = 1
  health_check_type         = "EC2"
  health_check_grace_period = 300
  vpc_zone_identifier       = var.public_subnets_ids
  termination_policies      = ["OldestInstance"]
  protect_from_scale_in     = true
  force_delete              = true

  tag {
    key                 = "Name"
    value               = format("%s-asg", local.prefix_name_lower)
    propagate_at_launch = true
  }

  dynamic "tag" {
    for_each = var.tags

    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}
