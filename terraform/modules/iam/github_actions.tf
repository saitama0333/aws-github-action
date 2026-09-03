resource "aws_iam_role" "github_actions" {
  name               = "${var.project_name}-${var.environment}-github-actions"
  assume_role_policy = data.aws_iam_policy_document.github_actions_assume_role.json

  tags = {
    Name = "${var.project_name}-${var.environment}-github-actions"
  }
}

data "aws_iam_policy_document" "github_actions_permissions" {
  statement {
    sid    = "ECRPushPull"
    effect = "Allow"

    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:CompleteLayerUpload",
      "ecr:InitiateLayerUpload",
      "ecr:PutImage",
      "ecr:UploadLayerPart"
    ]

    resources = [
      var.ecr_repository_arn
    ]
  }

  statement {
    sid    = "ECRGetAuthorizationToken"
    effect = "Allow"

    actions = [
      "ecr:GetAuthorizationToken"
    ]

    resources = ["*"]
  }
  statement {
    sid    = "ECSRegisterTaskDefinition"
    effect = "Allow"

    actions = [
      "ecs:RegisterTaskDefinition",
      "ecs:DescribeTaskDefinition"
    ]

    resources = ["*"]
  }

  statement {
    sid    = "ECSServiceDeployment"
    effect = "Allow"

    actions = [
      "ecs:UpdateService",
      "ecs:DescribeServices"
    ]

    resources = [
      var.ecs_service_arn
    ]
  }

  statement {
    sid    = "ELBDescribeLoadBalancers"
    effect = "Allow"

    actions = [
      "elasticloadbalancing:DescribeLoadBalancers"
    ]

    resources = ["*"]
  }

  statement {
    sid    = "ECSTaskRolePass"
    effect = "Allow"

    actions = [
      "iam:PassRole"
    ]

    resources = [
      aws_iam_role.ecs_task_execution.arn,
      aws_iam_role.ecs_task.arn
    ]

    condition {
      test     = "StringEquals"
      variable = "iam:PassedToService"
      values   = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy" "github_actions" {
  name   = "${var.project_name}-${var.environment}-github-actions-ecr"
  role   = aws_iam_role.github_actions.id
  policy = data.aws_iam_policy_document.github_actions_permissions.json
}
