variable "name" {}
variable "cluster" {}
variable "image" {}
variable "containerPort" {}
variable "environment" {}
variable "mountPoints" {
  default = null
}
variable "volumes" {
  default = null
}
variable "placementConstraints" {}
variable "discovery_namespace_id" {}
variable "security_groups" {}
variable "subnets" {
  type = list(string)
}
variable "task_role_arn" {}
variable "execution_role_arn" {}
variable "memory" {}
variable "desired_count" {
  default = 1
}
variable "create_lb" {
  default = false
}
variable "lb_arn" {
  default = null
}
variable "listener_port" {
  default = null
}
