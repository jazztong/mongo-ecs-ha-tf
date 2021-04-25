output "output" {
  value = {
    ec2_public_dns = aws_instance.this.public_dns
    service_dns    = "${aws_service_discovery_service.this.name}.${aws_service_discovery_private_dns_namespace.this.name}"
    dns_name       = aws_lb.this.dns_name
  }
}
