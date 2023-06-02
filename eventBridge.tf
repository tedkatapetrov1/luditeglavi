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
  arn       = aws_sns_topic.aws_logins.arn
  target_id = "SendToSNS"
}

resource "aws_sns_topic" "aws_logins" {
  name = "aws-console-logins"
}

resource "aws_sns_topic_policy" "default" {
  arn    = aws_sns_topic.aws_logins.arn
  policy = data.aws_iam_policy_document.sns_topic_policy.json
}