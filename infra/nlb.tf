resource "aws_lb" "this" {
  name               = "${var.app_id}-NLB"
  internal           = false
  load_balancer_type = "network"
  subnets            = data.aws_subnet_ids.this.ids
}

resource "aws_lb_listener" "tcp27017" {
  load_balancer_arn = aws_lb.this.arn
  port              = 27017
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

resource "aws_lb_target_group" "this" {
  name        = "${var.app_id}tg27017"
  port        = 27017
  protocol    = "TCP"
  target_type = "ip"
  vpc_id      = data.aws_vpc.this.id
}
