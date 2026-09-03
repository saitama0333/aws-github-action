resource "aws_iam_role" "ecs_task" {
  name               = var.ecs_task_role_name
  assume_role_policy = data.aws_iam_policy_document.ecs_tasks_assume_role.json

  tags = {
    Name = var.ecs_task_role_name
  }
}
