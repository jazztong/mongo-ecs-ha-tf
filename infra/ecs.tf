resource "aws_ecs_cluster" "this" {
  name = "${var.app_id}-cluster"
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

locals {
  taskRole_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
    "arn:aws:iam::aws:policy/AmazonElasticFileSystemClientFullAccess"
  ]
}

resource "aws_iam_role_policy_attachment" "task" {
  count = length(local.taskRole_arns)

  role       = aws_iam_role.task.name
  policy_arn = element(local.taskRole_arns, count.index)
}

resource "aws_iam_role_policy" "task" {
  name   = "${var.app_id}-TASK-ROLE-POLICY"
  role   = aws_iam_role.task.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
          "logs:CreateLogGroup",
          "ssm:GetParameters",
          "ssm:GetParameter",
          "xray:PutTraceSegments"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role" "task" {
  name = "${var.app_id}-TASK-ROLE"
  path = "/"

  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Action" : "sts:AssumeRole",
          "Principal" : {
            "Service" : "ecs-tasks.amazonaws.com"
          },
          "Effect" : "Allow",
        }
      ]
    }
  )
}

