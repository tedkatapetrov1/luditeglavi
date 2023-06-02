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
resource "aws_iam_role_policy_attachment" "codebuild_attachment" {
  role       = aws_iam_role.eventbridge_codebuild_role.id
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
