resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_info.cidr_block
  tags = {
    "Name" = var.vpc_info.name
  }
}
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_subnet_info.cidr_block
  availability_zone = var.public_subnet_info.availability_zone
  tags = {
    "Name" = var.public_subnet_info.name
  }
  depends_on = [
    aws_vpc.vpc,
  ]
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    "Name" = var.igw_name
  }
  depends_on = [
    aws_vpc.vpc
  ]
}
resource "aws_route_table" "routetablepub" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    "Name" = var.rt_name
  }
  depends_on = [ aws_vpc.vpc ]
}
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.routetablepub.id
  depends_on = [ 
    aws_vpc.vpc, 
    aws_route_table.routetablepub 
    ]
}
