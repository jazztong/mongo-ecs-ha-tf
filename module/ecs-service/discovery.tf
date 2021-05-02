resource "aws_service_discovery_service" "this" {
  name = var.name

  dns_config {
    namespace_id = var.discovery_namespace_id

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
