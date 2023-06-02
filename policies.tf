resource "aws_iam_role" "eventbridge_codebuild_role" {
  name = "eventbridge_codebuild_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "events.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "eventbridge_codebuild_policy" {
  name        = "eventbridge_codebuild_policy"
  description = "Policy allowing EventBridge to start CodeBuild"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EventBridgeCodeBuildPermissions",
      "Effect": "Allow",
      "Action": [
        "codebuild:StartBuild"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "eventbridge_codebuild_attachment" {
  role       = aws_iam_role.eventbridge_codebuild_role.name
  policy_arn = aws_iam_policy.eventbridge_codebuild_policy.arn
}

resource "aws_iam_role" "codebuilder_role" {
  name = "test_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "tag-value"
  }
}
resource "aws_iam_role_policy_attachment" "codebuild_attachment" {
  role       = aws_iam_role.codebuilder_role.name
  policy_arn = var.policy_full_admin
}
