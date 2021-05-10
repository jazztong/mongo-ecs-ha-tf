resource "aws_security_group" "this" {
  name        = "${var.app_id}-SG"
  description = "Security group to allow access to Mongo"
  vpc_id      = data.aws_vpc.this.id

  # Only enable when nlb enabled
  dynamic "ingress" {
    for_each = var.nlb_enabled ? [1] : []
    content {
      from_port   = 27017
      to_port     = 27017
      protocol    = "tcp"
      cidr_blocks = var.ingress_cidr_blocks
    }
  }

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.app_id}-sg"
  }
}
