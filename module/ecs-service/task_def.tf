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
      host_path = lookup(volume.value, "host_path", null)
      dynamic "docker_volume_configuration" {
        for_each = lookup(volume.value, "docker_volume_configuration", null) == null ? [] : [lookup(volume.value, "docker_volume_configuration", null)]
        content {
          scope         = lookup(docker_volume_configuration.value, "scope", null)
          autoprovision = lookup(docker_volume_configuration.value, "autoprovision", null)
          driver        = lookup(docker_volume_configuration.value, "driver", null)
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
      "command" : var.command,
      "healthCheck" : var.healthCheck,
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
