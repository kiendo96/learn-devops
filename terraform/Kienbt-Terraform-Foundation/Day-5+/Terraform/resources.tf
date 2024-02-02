##################################################################################
# PROVIDERS
##################################################################################

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.region
}

##################################################################################
# DATA
##################################################################################

data "aws_availability_zones" "available" {}

data "aws_ami" "aws-linux" {
  most_recent = true
  owners      = ["950749955491"]

  filter {
    name   = "name"
    values = ["booksite-amalin*"]
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

##################################################################################
# RESOURCES
##################################################################################

#Random ID
resource "random_integer" "rand" {
  min = 10000
  max = 99999
}

resource "aws_vpc" "vpc" {
    cidr_block = var.network_address_space[terraform.workspace]

    tags = merge(local.common_tags, { Name = "${local.env_name}-vpc" })
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(local.common_tags, { Name = "${local.env_name}-igw" })

}

resource "aws_subnet" "subnet" {
          count = var.subnet_count[terraform.workspace]
          cidr_block = cidrsubnet(var.network_address_space[terraform.workspace], 8, count.index)
    vpc_id = aws_vpc.vpc.id
    map_public_ip_on_launch = true
    availability_zone = data.aws_availability_zones.available.names[count.index]

    tags = merge(local.common_tags, { Name = "${local.env_name}-subnet${count.index +1}" })
}

# ROUTING
resource "aws_route_table" "rtb" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(local.common_tags, { Name = "${local.env_name}-rtb" })
}

resource "aws_route_table_association" "rta-subnet" {
    count = var.subnet_count[terraform.workspace]
    subnet_id = aws_subnet.subnet[count.index].id
    route_table_id = aws_route_table.rtb.id
}

# SECURIRY 

resource "aws_security_group" "elb-sg" {
  name   = "nginx_elb_sg"
  vpc_id = aws_vpc.vpc.id

  #Allow HTTP from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #allow all outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, { Name = "${local.env_name}-elb-sg" })
}

resource "aws_security_group" "nginx-sg" {
  name   = "nginx_sg"
  vpc_id = aws_vpc.vpc.id

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "TCP"
    cidr_blocks = [var.network_address_space[terraform.workspace]]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = merge(local.common_tags, { Name = "${local.env_name}-nginx-sg" })
}

resource "aws_elb" "web" {
  name = "${local.env_name}-nginx-elb"

  subnets         = aws_subnet.subnet[*].id
  security_groups = [aws_security_group.elb-sg.id]
  instances       = aws_instance.nginx[*].id

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  tags = merge(local.common_tags, { Name = "${local.env_name}-elb" })
}

resource "aws_instance" "nginx" {
  count = var.instance_count[terraform.workspace]
  ami = data.aws_ami.aws-linux.id
  instance_type = var.instance_size[terraform.workspace]
  subnet_id = aws_subnet.subnet[count.index % var.subnet_count[terraform.workspace]].id
  vpc_security_group_ids = [aws_security_group.nginx-sg.id]
  key_name = var.key_name
  # iam_instance_profile = aws_iam_instance_profile.nginx_profile.name
  # depends_on = [aws_iam_role_policy.allow_s3_all]

  tags = merge(local.common_tags, { Name = "${local.env_name}-nginx${count.index + 1}" })

}

# resource "aws_iam_role" "allow_nginx_s3" {
#   name = "${local.env_name}_allow_nginx_s3"

#   assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Action": "sts:AssumeRole",
#       "Principal": {
#         "Service": "ec2.amazonaws.com"
#       },
#       "Effect": "Allow",
#       "Sid": ""
#     }
#   ]
# }
# EOF
# }

# resource "aws_iam_instance_profile" "nginx_profile" {
#   name = "${local.env_name}_nginx_profile"
#   role = aws_iam_role.allow_nginx_s3.name
# }

# resource "aws_iam_role_policy" "allow_s3_all" {
#   name = "${local.env_name}_allow_s3_all"
#   role = aws_iam_role.allow_nginx_s3.name

#   policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Action": [
#         "s3:*"
#       ],
#       "Effect": "Allow",
#       "Resource": [
#                 "arn:aws:s3:::${local.s3_bucket_name}",
#                 "arn:aws:s3:::${local.s3_bucket_name}/*"
#             ]
#     }
#   ]
# }
# EOF

# }

# resource "aws_s3_bucket" "web_bucket" {
#   bucket        = local.s3_bucket_name
#   acl           = "private"
#   force_destroy = true

#   tags = merge(local.common_tags, { Name = "${local.env_name}-web-bucket" })

# }

# resource "aws_s3_bucket_object" "website" {
#   bucket = aws_s3_bucket.web_bucket.bucket
#   key    = "/website/index.html"
#   source = "./index.html"

# }

# resource "aws_s3_bucket_object" "graphic" {
#   bucket = aws_s3_bucket.web_bucket.bucket
#   key    = "/website/Terraform_logo.png"
#   source = "./Terraform_logo.png"

# }


