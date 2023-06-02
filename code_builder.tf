resource "aws_codebuild_project" "my-codebuild_project" {
  name          = "test-project"
  description   = "test_codebuild_project"
  build_timeout = "5"
  service_role  = aws_iam_role.example.arn
  source {
    buildspec = templatefile("${path.module}/buildspec.yaml", {})
  }

  # environment {
  #   compute_type                = "BUILD_GENERAL1_SMALL"
  #   image                       = "aws/codebuild/standard:1.0"
  #   type                        = "LINUX_CONTAINER"
  #   image_pull_credentials_type = "CODEBUILD"

  #   environment_variable {
  #     name  = "SOME_KEY1"
  #     value = "SOME_VALUE1"
  #   }

}

