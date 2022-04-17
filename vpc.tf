resource "aws_vpc" "main" {
  cidr_block = var.cidr_block

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public-a" {
  vpc_id = aws_vpc.main.id
  # cidr_block = var.subnet_cidr_tag["public-a"]
  # availability_zone = var.subnet_az_tag["public-a"]
  cidr_block =  var.subnet_cidr
  availability_zone = var.subnet_az

  tags = {
    # Name = "${lookup(var.subnet_name_tag, "public-a")}"
    Name = var.subnet_name
  }
}

resource "aws_route_table" "public-a" {
  vpc_id = aws_vpc.main.id

  # depends_on = [
  #   aws_internet_gateway.main,
  #   aws_vpc.main,
  #   aws_subnet.public_a
  # ]

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.igw_name
  }
}

resource "aws_route_table_association" "public-a" {
  route_table_id = aws_route_table.public-a.id
  subnet_id = aws_subnet.public-a.id
}
