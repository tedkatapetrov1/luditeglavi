resource "aws_cloudwatch_event_rule" "daily_trigger" {
  name        = "daily_trigger_rule"
  description = "Trigger daily at 20:00"

  schedule_expression = "cron(0 20 * * ? *)"

  tags = {
    Name = "daily_trigger_rule"
  }
}

resource "aws_cloudwatch_event_target" "sns" {
  rule      = aws_cloudwatch_event_rule.daily_trigger.name
  arn       = aws_codebuild_project.my_codebuild_project.arn
  target_id = "InvokeCodeBuild"
  role_arn = aws_iam_role.eventbridge_codebuild_role.arn
}
