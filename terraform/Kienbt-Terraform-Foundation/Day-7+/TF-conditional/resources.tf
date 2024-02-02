data "aws_ami" "aws-linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-hvm*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "myec2_dev" {
  ami = data.aws_ami.aws-linux.id
  instance_type = "t2.micro"
  count = var.istest == true ? 2 : 0
}

resource "aws_instance" "myec2_prod" {
  ami = data.aws_ami.aws-linux.id
  instance_type = "t2.large"
  count = var.istest == false ? 1 : 0
}