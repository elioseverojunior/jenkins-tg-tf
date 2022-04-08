locals {
  cloud_watch_name            = format("%s-cloudwatch-log-group", local.prefix_name_lower)
  prefix_name_title           = format("%s-%s-Efs", title(var.environment), title(join("-", split("-", var.application))))
  prefix_name_lower           = lower(local.prefix_name_title)
  prefix_name_lower_underline = replace(lower(local.prefix_name_title), "-", "_")
  prefix_name_upper           = upper(local.prefix_name_title)
  efs_security_groups         = flatten(sort(concat(flatten([var.additional_security_groups, var.security_group_efs_id]))))
}
