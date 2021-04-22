data "aws_vpc" "this" {
  default = true
}

data "aws_subnet_ids" "this" {
  vpc_id = data.aws_vpc.this.id
}

data "aws_region" "this" {}

data "template_cloudinit_config" "userdata" {
  part {
    filename     = "init.sh"
    content_type = "text/x-shellscript"
    content      = local.user_data
  }
}

data "aws_ami" "amzlinux2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm-*-x86_64*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}


data "aws_ebs_volume" "this" {
  most_recent = true

  filter {
    name   = "attachment.instance-id"
    values = [aws_instance.this.id]
  }
}
