resource "aws_ecs_service" "this" {
  name        = var.name
  cluster     = var.cluster
  launch_type = "EC2"

  task_definition      = aws_ecs_task_definition.this.arn
  force_new_deployment = false
  desired_count        = var.desired_count

  dynamic "load_balancer" {
    for_each = var.create_lb ? aws_lb_target_group.this : []
    content {
      target_group_arn = load_balancer.value.arn
      container_name   = var.name
      container_port   = var.containerPort
    }
  }

  network_configuration {
    subnets          = var.subnets
    security_groups  = var.security_groups
    assign_public_ip = false
  }

  service_registries {
    registry_arn = aws_service_discovery_service.this.arn
  }

  # Service only run one instance at a time
  deployment_maximum_percent         = 100
  deployment_minimum_healthy_percent = 0
}
