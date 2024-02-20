resource "aws_vpc" "vpc" {
  cidr_block = var.network_address_space[terraform.workspace]
  tags = merge(local.common_tags, { Name = "${local.env_name}-vpc" })
}

resource "aws_subnet" "subnet" {
  count = var.subnet_count[terraform.workspace]
  vpc_id = aws_vpc.vpc.id
  cidr_block = cidrsubnet(var.network_address_space[terraform.workspace], 8, count.index)
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = merge(local.common_tags, { Name = "${local.env_name}-subnet${count.index + 1}" })
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = merge(local.common_tags, { Name = "${local.env_name}-igw"})
}

resource "aws_route_table" "rtb" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = merge(local.common_tags, { Name = "${local.env_name}-rtb"})
}

resource "aws_route_table_association" "rta-subnet" {
  count = var.subnet_count[terraform.workspace]
  subnet_id = aws_subnet.subnet[count.index].id
  route_table_id = aws_route_table.rtb.id
}

resource "aws_security_group" "lb-sg" {
  name = "nginx_lb_sg"
  vpc_id = aws_vpc.vpc.id

  dynamic "ingress" {
    for_each = var.sg_port
    content {
      from_port = ingress.value
      to_port = ingress.value
      protocol = "tcp"
      cidr_blocks = [ "0.0.0.0/0" ]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
  }
  tags = merge(local.common_tags, { Name = "${local.env_name}-lb-sg"})
}

# resource "aws_vpc_security_group_ingress_rule" "lb-sg-allow-port-80" {
#   security_group_id = aws_security_group.lb-sg.id
#   cidr_ipv4 = aws_vpc.vpc.id
#   from_port = 80
#   ip_protocol = "tcp"
#   to_port = 80
# }

# resource "aws_vpc_security_group_ingress_rule" "lb-sg-allow-port-22" {
#   security_group_id = aws_security_group.lb-sg.id
#   cidr_ipv4 = aws_vpc.vpc.id
#   from_port = 22
#   ip_protocol = "tcp"
#   to_port = 22
# }

# resource "aws_vpc_security_group_egress_rule" "allow-egress-nginx-sg" {
#   security_group_id = aws_security_group.nginx-sg.id
#   cidr_ipv4         = "0.0.0.0/0"
#   ip_protocol       = "-1" # semantically equivalent to all ports
# }
