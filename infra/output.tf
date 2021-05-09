output "ec2_id" {
  value = aws_instance.this.id
}

output "ec2_dns" {
  value = aws_instance.this.public_dns
}

output "nlb_dns" {
  value = var.nlb_enabled ? aws_lb.this.*.dns_name : null
}
