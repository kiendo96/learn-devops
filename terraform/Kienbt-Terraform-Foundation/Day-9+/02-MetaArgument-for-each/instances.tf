data "aws_availability_zones" "myzone" {
  
  filter {
    name = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

resource "aws_instance" "myec2vm" {
  ami = data.aws_ami.amzlinux2.id
  instance_type = var.instance_type
  user_data = file("${path.module}/install.sh")
  key_name = var.instance_keypair
  vpc_security_group_ids = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id]
  # Create EC2 Instance in all Availability Zones in VPC
  for_each = toset(data.aws_availability_zones.myzone.names)
  availability_zone = each.key

  tags = {
    "Name" = "for_each-Demo-${each.value}"
  }
}