resource "aws_codebuild_project" "my_codebuild_project" {
  name         = "my-codebuild-project"
  description  = "my-codebuild-project"
  service_role = aws_iam_role.codebuilder_role.id

  artifacts {
    type = "NO_ARTIFACTS"
  }
  source {
    type      = "NO_SOURCE"
    buildspec = templatefile("${path.module}/buildspec.yaml", {})
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:1.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

  }

}

