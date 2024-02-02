resource "aws_instance" "myec2vm" {
  ami = data.aws_ami.amzlinux2.id
  instance_type = var.instance_type
  user_data = file("${path.module}/userdata.sh")
  key_name = var.instance_keypair
  vpc_security_group_ids = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id]
  # Create EC2 instance in all Availability Zones of A VPC
  #for_each = toset(data.aws_availability_zones.myzone.names)
  for_each = toset(keys({ for az, details in data.aws_ec2_instance_type_offerings.my_ins_type:
  az => details.instance_types if length(details.instance_types) != 0 }))
  availability_zone = each.key # You can also use each.value because for list items each.key == each.value
  
  tags = {
    "Name" = "For-Each-Demo-${each.key}"
  }
}