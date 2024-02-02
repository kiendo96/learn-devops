resource "aws_instance" "myec2vm" { 
    ami = data.aws_ami.amzlinux2.id
    # instance_type = var.instance_type ==> Run normal
    # instance_type = var.instance_type_list[1] ==> With list
    instance_type = var.instance_type_map["prod"]
    user_data = file("${path.module}/install.sh")

    key_name = var.instance_keypair
    vpc_security_group_ids = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id]
    count = 2

    tags = {
      "Name" = "Count-Demo-${count.index}"
    }

}