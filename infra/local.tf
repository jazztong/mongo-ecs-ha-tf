locals {
  role_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role",
    "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  ]

  user_data = templatefile("${path.module}/tmpl/user_data.tmpl.sh", {
    ECS_CLUSTER       = aws_ecs_cluster.this.name
    REGION            = data.aws_region.this.name
    ECS_USER_PASSWORD = var.ecs_user_password
  })
}
