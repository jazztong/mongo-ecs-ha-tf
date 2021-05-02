resource "aws_service_discovery_private_dns_namespace" "this" {
  name = "ecs.load"
  vpc  = data.aws_vpc.this.id
}
