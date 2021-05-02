module "mongo_primary" {
  source = "../module/ecs-service"

  cluster       = aws_ecs_cluster.this.id
  name          = "${var.app_id}-primary"
  image         = var.image
  containerPort = 27017

  create_lb     = true
  lb_arn        = aws_lb.this.arn
  listener_port = 27017

  desired_count = 1
  memory        = var.memory
  environment = [
    { "name" : "MONGODB_ROOT_PASSWORD", "value" : "mypassword" },
    { "name" : "MONGODB_ADVERTISED_HOSTNAME", "value" : "mongo-ecs-primary.ecs.demo" },
    { "name" : "MONGODB_REPLICA_SET_MODE", "value" : "primary" },
    { "name" : "MONGODB_REPLICA_SET_KEY", "value" : "replicasetkey123" }
  ]
  volumes = [
    {
      "name" : "primary-data",
      "docker_volume_configuration" : {
        "scope" : "shared",
        "autoprovision" : true,
        "driver" : "local"
      }
    }
  ]
  mountPoints = [
    {
      "containerPath" : "/bitnami",
      "sourceVolume" : "primary-data"
    }
  ]
  placementConstraints = [
    {
      "expression" : "attribute:mongo == primary",
      "type" : "memberOf"
    }
  ]
  discovery_namespace_id = aws_service_discovery_private_dns_namespace.this.id
  security_groups        = [aws_security_group.this.id]
  subnets                = data.aws_subnet_ids.this.ids
  task_role_arn          = aws_iam_role.task.arn
  execution_role_arn     = aws_iam_role.task.arn

  depends_on = [
    aws_lb.this
  ]
}
