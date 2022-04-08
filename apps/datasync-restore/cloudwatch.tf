data "aws_iam_policy_document" "cloudwatch_log_group" {
  depends_on = [
    aws_cloudwatch_log_group.this
  ]
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:PutLogEventsBatch",
    ]
    resources = [aws_cloudwatch_log_group.this.arn]
    principals {
      identifiers = ["datasync.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_cloudwatch_log_resource_policy" "this" {
  policy_document = data.aws_iam_policy_document.cloudwatch_log_group.json
  policy_name     = format("%s-%s-cw-log-policy", var.environment, var.application)
}

resource "aws_cloudwatch_log_group" "this" {
  name              = format("%s-%s-cw-log-group", var.environment, var.application)
  retention_in_days = 14

  tags = merge(var.tags,
    {
      Name        = format("%s-%s-cw-log-group", var.environment, var.application)
      Environment = var.environment
    }
  )
}
