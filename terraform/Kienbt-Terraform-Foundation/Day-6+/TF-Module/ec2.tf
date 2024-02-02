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

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "instance_module"

  ami                    = data.aws_ami.aws-linux.id
  instance_type          = "t2.micro"
  key_name               = "btk-terraform"
  monitoring             = false
  vpc_security_group_ids = ["sg-0177033ba95c6f456"]
  subnet_id              = "subnet-04c33b00af0e9daa6"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}