locals {
  prefix_name_title           = format("%s-%s", title(var.environment), title(join("-", split("-", var.application))))
  prefix_name_lower           = lower(local.prefix_name_title)
  prefix_name_lower_underline = replace(lower(local.prefix_name_title), "-", "_")
  prefix_name_upper           = upper(local.prefix_name_title)
}