resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${var.prefix}_vpc"
  }
}

data "aws_availability_zones" "available" {}


resource "aws_subnet" "subnets" {
  count                   = 2
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.${count.index}.0/24"
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.prefix}_vpc_subnet_${count.index}"
  }
}

resource "aws_internet_gateway" "vpc_gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.prefix}_vpc_gateway"
  }
}

resource "aws_route_table" "vpc_route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc_gateway.id
  }
  tags = {
    Name = "${var.prefix}_vpc_route_table"
  }
}

resource "aws_route_table_association" "vpc_route_table_association" {
  count          = 2
  subnet_id      = aws_subnet.subnets.*.id[count.index]
  route_table_id = aws_route_table.vpc_route_table.id
}

