resource "aws_ecs_task_definition" "this" {
  family                   = var.name
  memory                   = var.memory
  requires_compatibilities = ["EC2"]
  task_role_arn            = var.task_role_arn
  execution_role_arn       = var.execution_role_arn
  network_mode             = "awsvpc"


  dynamic "volume" {
    for_each = var.volumes == null ? [] : var.volumes
    content {
      name      = volume.value.name
      host_path = try(volume.value.host_path, null)
      dynamic "docker_volume_configuration" {
        for_each = can(volume.value.docker_volume_configuration) ? [try(volume.value.docker_volume_configuration, {})] : []
        content {
          scope         = try(docker_volume_configuration.value.scope, null)
          autoprovision = try(docker_volume_configuration.value.autoprovision, null)
          driver        = try(docker_volume_configuration.value.driver, null)
        }
      }
    }
  }

  container_definitions = jsonencode(
    [{
      "name" : var.name
      "image" : var.image,
      "portMappings" : [
        { containerPort = var.containerPort }
      ],
      "environment" : var.environment,
      "mountPoints" : var.mountPoints,
      "placementConstraints" : var.placementConstraints,
      "volumes" : var.volumes,
      "logConfiguration" : {
        "logDriver" : "awslogs",
        "options" : {
          "awslogs-create-group" : "true",
          "awslogs-group" : "/ecs/${var.name}",
          "awslogs-region" : data.aws_region.this.name,
          "awslogs-stream-prefix" : "ecs"
        }
      },
    }]
  )
}
