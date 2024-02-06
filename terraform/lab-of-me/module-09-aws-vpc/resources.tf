#random number
resource "random_integer" "rand" {
  min = 10000
  max = 99999
}

#vpc
resource "aws_vpc" "vpc" {
  cidr_block = var.network_address_space[terraform.workspace]
  tags = merge(local.common_tag, { Name = "${local.environment}-vpc"})
}

#internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(local.common_tag, { Name = "${local.environment}-igw"})
}

#subnet
resource "aws_subnet" "subnet" {
  count = var.subnet_count[terraform.workspace]
  cidr_block = cidrsubnet(var.network_address_space[terraform.workspace], 8, count.index)
  vpc_id = aws_vpc.vpc.id
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.azs.names[count.index]

  tags = merge(local.common_tag, { Name = "${local.environment}-subnet${count.index + 1}"})
}

#routing subnet
resource "aws_route_table" "rtb" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = merge(local.common_tag, { Name = "${local.environment}-rtb"})
}

resource "aws_route_table_association" "rta-subnet" {
  count = var.subnet_count[terraform.workspace]
  subnet_id = aws_subnet.subnet[count.index].id
  route_table_id = aws_route_table.rtb.id
}

resource "aws_security_group" "lb-sg" {
  name = "nginx_lb_sg"
  vpc_id = aws_vpc.vpc.id

  tags = merge(local.common_tag, { Name = "${local.environment}-lb-sg"})
}

resource "aws_vpc_security_group_ingress_rule" "allow-ingress-lb-sg" {
  security_group_id = aws_security_group.lb-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow-egress-lb-sg" {
  security_group_id = aws_security_group.lb-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_security_group" "nginx-sg" {
  name = "nginx_sg"
  vpc_id = aws_vpc.vpc.id

  tags = merge(local.common_tag, { Name = "${local.environment}-nginx-sg"})
}

resource "aws_vpc_security_group_ingress_rule" "allow-ingress-nginx-sg" {
  security_group_id = aws_security_group.nginx-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}
resource "aws_vpc_security_group_ingress_rule" "allow-ssh-nginx-sg" {
  security_group_id = aws_security_group.nginx-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow-egress-nginx-sg" {
  security_group_id = aws_security_group.nginx-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_lb" "lb" {
  name               = "${local.environment}-nginx-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb-sg.id]
  subnets            = [for s in aws_subnet.subnet : s.id]

  enable_deletion_protection = false

  tags = merge(local.common_tag, { Name = "${local.environment}-lb-delete"})
}

# resource "aws_iam_role" "allow_nginx_s3" {
#   name = "${local.environment}_allow_nginx_s3"

#   assume_role_policy = jsonencode({
#     "Version": "2012-10-17",
#     "Statement": [
#       {
#         "Action": "sts:AssumeRole",
#         "Principal": {
#           "Service": "ec2.amazonaws.com"
#         },
#         "Effect": "Allow",
#         "Sid" : ""
#       }
#     ]
#   })
# }

# resource "aws_iam_instance_profile" "nginx_profile" {
#   name = "${local.environment}_nginx_profile"
#   role = aws_iam_role.allow_nginx_s3.name
# }

# resource "aws_iam_role_policy" "allow_s3_all" {
#   name = "${local.environment}_allow_s3_all"
#   role = aws_iam_role.allow_nginx_s3.name

#   policy = jsonencode({
#     "Version": "2012-10-17",
#     "Statement": [
#       {
#         "Action": [
#           "s3:*"
#         ],
#         "Effect": "Allow",
#         "Resource": [
#           "arn:aws:s3:::${local.s3_bucket_name}",
#           "arn:aws:s3:::${local.s3_bucket_name}/*"
#         ]
#       }
#     ]
#   })
# }

# resource "aws_s3_bucket" "web_bucket" {
#   bucket = local.s3_bucket_name
#   force_destroy = true

#   tags = merge(local.common_tag, { Name = "${local.environment}-web-bucket"})
# }

# resource "aws_s3_object" "website" {
#   bucket = aws_s3_bucket.web_bucket.bucket
#   key = "/website/index.html"
#   source = "./index.html"
# }

# resource "aws_s3_object" "graphic" {
#   bucket = aws_s3_bucket.web_bucket.bucket
#   key = "/website/Terraform_logo.png"
#   source = "./Terraform_logo.png"
# }

resource "aws_instance" "nginx" {
  count = var.instance_count[terraform.workspace]
  ami = data.aws_ami.amzlinux2.id
  instance_type = var.instance_type[terraform.workspace]
  subnet_id = aws_subnet.subnet[count.index % var.subnet_count[terraform.workspace]].id
  vpc_security_group_ids = [ aws_security_group.nginx-sg.id ]
  key_name = var.key_name

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file(var.private_key_path)
  }

  provisioner "remote-exec" {
    inline = [
      "sudo amazon-linux-extras install nginx1 -y",
      "sudo systemctl start nginx"
    ]
  }

  tags = merge(local.common_tag, { Name = "${local.environment}-nginx${count.index + 1}"})
}

resource "aws_lb_target_group" "lb_tg" {
  name = "nginx-target"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.vpc.id
}

resource "aws_lb_listener" "lbl" {
  load_balancer_arn = aws_lb.lb.arn
  port = "80"
  protocol = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "tg-attach" {
  count = var.instance_count[terraform.workspace]
  target_group_arn = aws_lb_target_group.lb_tg.arn
  target_id        = aws_instance.nginx[count.index].id
  port             = 80
}
