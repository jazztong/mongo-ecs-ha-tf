output "output" {
  value = {
    ec2_public_dns = aws_instance.this.public_dns
    dns_name       = aws_lb.this.dns_name
  }
}
