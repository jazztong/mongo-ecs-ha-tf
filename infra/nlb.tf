resource "aws_lb" "this" {
  count              = var.nlb_enabled ? 1 : 0
  name               = "${var.app_id}-NLB"
  internal           = false
  load_balancer_type = "network"
  subnets            = data.aws_subnet_ids.this.ids
}
