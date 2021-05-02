data "aws_region" "this" {}
data "aws_subnet" "selected" {
  id = var.subnets[0]
}