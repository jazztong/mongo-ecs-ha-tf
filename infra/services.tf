resource "aws_ecs_service" "this" {
  name        = "${var.app_id}-service"
  cluster     = aws_ecs_cluster.this.id
  launch_type = "EC2"

  task_definition = aws_ecs_task_definition.this.arn

  desired_count = 1

  load_balancer {
    target_group_arn = aws_lb_target_group.this.arn
    container_name   = var.app_id
    container_port   = 27017
  }

  network_configuration {
    subnets          = data.aws_subnet_ids.this.ids
    security_groups  = [aws_security_group.this.id]
    assign_public_ip = false
  }

  service_registries {
    registry_arn = aws_service_discovery_service.this.arn
  }

  # Service only run one instance at a time
  deployment_maximum_percent         = 100
  deployment_minimum_healthy_percent = 0
}
