resource "aws_service_discovery_service" "this" {
  name = var.app_id

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.this.id

    dns_records {
      ttl  = 86400
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }

  health_check_custom_config {
    failure_threshold = 1
  }
}


resource "aws_service_discovery_private_dns_namespace" "this" {
  name = "ecs.load"
  vpc  = data.aws_vpc.this.id
}
