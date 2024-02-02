# Resource: EC2 Instance
resource "aws_instance" "myec2vm" {
  ami = "ami-0742b4e673072066f"
  instance_type = "t2.micro"
  user_data = file("${path.module}/app1-install.sh")
  key_name = "ssh-to-ec2"
  tags = {
    "Name" = "EC2 Demo"
  }
}