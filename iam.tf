resource "aws_iam_role" "task" {
  name = "${var.prefix}-ecs-task-role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ecs-tasks.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "ecs_exec" {
  count = var.enable_ecs_exec ? 1 : 0

  name = "${var.prefix}-ecs-exec-role"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "ssmmessages:CreateControlChannel",
          "ssmmessages:CreateDataChannel",
          "ssmmessages:OpenControlChannel",
          "ssmmessages:OpenDataChannel",
        ]
        "Resource" : [
          "*",
        ]
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_exec" {
  count = var.enable_ecs_exec ? 1 : 0

  policy_arn = aws_iam_policy.ecs_exec[0].arn
  role       = aws_iam_role.task.name
}

resource "aws_iam_role" "task_execution" {
  name = "${var.prefix}-ecs-task-execution-role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ecs-tasks.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "task_execution" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  role       = aws_iam_role.task_execution.name
}

resource "aws_iam_role_policy_attachment" "task" {
  for_each = var.ecs_task_policy_arns

  policy_arn = each.value
  role       = aws_iam_role.task.name
}
