resource "aws_lb_listener" "this" {
  count             = var.create_lb ? 1 : 0
  load_balancer_arn = var.lb_arn
  port              = var.listener_port
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this[0].arn
  }
}

resource "aws_lb_target_group" "this" {
  count                = var.create_lb ? 1 : 0
  name                 = "${var.name}tg${var.listener_port}"
  port                 = var.containerPort
  protocol             = "TCP"
  target_type          = "ip"
  vpc_id               = data.aws_subnet.selected.vpc_id
  deregistration_delay = 5
  health_check {
    enabled             = true
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 10
    port                = var.containerPort
    protocol            = "TCP"
  }
}
