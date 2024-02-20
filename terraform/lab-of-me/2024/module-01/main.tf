resource "aws_vpc" "vpc" {
  cidr_block = var.network_address_space[terraform.workspace]
  tags = merge(local.common_tags, { Name = "${local.env_name}-vpc" })
}

resource "aws_subnet" "subnet" {
  count = var.subnet_count[terraform.workspace]
  vpc_id = aws_vpc.vpc.id
  cidr_block = cidrsubnet(aws_vpc.vpc.id, 8, count.index)
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