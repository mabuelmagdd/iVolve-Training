resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "main-vpc"
  }
}

resource "aws_subnet" "public" {
  count = 2

  cidr_block = element(var.subnet_cidrs, count.index)
  vpc_id     = aws_vpc.main.id
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-${count.index}"
  }
}
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = aws_subnet.public.*.id
}



