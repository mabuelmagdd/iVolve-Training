######## VPC #######
resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"
  tags = {
    Name = "Lab19 VPC"
  }
}
######## Subnets #######
resource "aws_subnet" "pub_subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.pub_subnet_cidr_block
  availability_zone = var.az
  map_public_ip_on_launch = true
  tags = {
    Name = "Lab19 Public Subnet"
  }
}
######## IGW and Route Table #######
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Lab19 InternetGW"
  }
}
resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "Lab19 Main Route Table"
  }
}
resource "aws_route_table_association" "pub-association" {
  subnet_id = aws_subnet.pub_subnet.id
  route_table_id = aws_route_table.main.id
}


