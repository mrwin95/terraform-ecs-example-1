data "aws_iam_policy_document" "ecs_tasks_execution_role_policy" {
  statement {
    actions = [ "sts:AssumeRole" ]

    principals {
      type = "Service"
      identifiers = [ "ecs-tasks.amazonaws.com" ]
    }
  }
}

resource "aws_iam_role" "ecs_tasks_execution_role" {
  name = "${var.project_name}-ecs-tasks-execution-role"
  assume_role_policy = aws_iam_policy_document.ecs_tasks_execution_role_policy.json
}

resource "aws_iam_role_policy_attachment" "ecs_tasks_execution_role" {
  role = aws_iam_role.ecs_tasks_execution_role.name
  policy_arn = "arn:aws:iam:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}