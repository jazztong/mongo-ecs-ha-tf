variable "ingress_cidr_blocks" {
  description = "Allow traffic from Cidr blocks, override for internal Cidr blocks"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "app_id" {
  description = "Application ID"
  type        = string
  default     = "mongo-ecs"
}

variable "volume_size" {
  description = "Volume size of root device"
  type        = number
  default     = 30
}

variable "volume_iops" {
  description = "Volume iops size, only apply to io1 io2"
  type        = number
  default     = 1000
}

variable "volume_type" {
  description = "Volume type use in EC2,gp,io1,io2"
  type        = string
  default     = "gp2"
}

variable "memory" {
  description = "Fargate Memory"
  type        = number
  default     = 512
}

variable "cpu" {
  description = "Fargate CPU"
  type        = number
  default     = 1024
}

variable "provisioned_throughput_in_mibps" {
  description = "EFS througput"
  type        = number
  default     = 150
}

variable "instance_type" {
  description = "Instance type"
  type        = string
  default     = "m5.large"
}

variable "image" {
  type    = string
  default = "docker.io/bitnami/mongodb:4.4-debian-10"
}

variable "restore_ami" {
  description = "AMI to restore the EC2"
  type        = string
  default     = null
}

variable "nlb_enabled" {
  description = "Enable NLB"
  type        = bool
  default     = false
}

variable "primary_enabled" {
  description = "Enable primary node, min setup"
  type        = bool
  default     = true
}

variable "secondary_enabled" {
  description = "Enable secondary node for replica setup"
  type        = bool
  default     = true
}

variable "arbiter_enabled" {
  description = "Enable arbiter setup for replica"
  type        = bool
  default     = true
}
