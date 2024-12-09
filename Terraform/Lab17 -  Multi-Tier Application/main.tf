###### VPC #####
data "aws_vpc" "ivolve" {
  filter {
    name   = "tag:Name"
    values = ["ivolve"]
  }
}

###### Subnets #####
resource "aws_subnet" "public_subnet" {
  vpc_id            = data.aws_vpc.ivolve.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = data.aws_vpc.ivolve.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
}
######## IGW and Route Table #######
resource "aws_internet_gateway" "main" {
  vpc_id = data.aws_vpc.ivolve.id

  tags = {
    Name = "InternetGW"
  }
}
resource "aws_route_table" "main" {
  vpc_id = data.aws_vpc.ivolve.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "Main Route Table"
  }
}
resource "aws_route_table_association" "route_table_association" {
  subnet_id = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.main.id
}

###### SG for instance #####
resource "aws_security_group" "ec2_sg" {
  vpc_id = data.aws_vpc.ivolve.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
# Security Group for RDS
resource "aws_security_group" "rds_sg" {
  vpc_id = data.aws_vpc.ivolve.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.ec2_sg.id] # Allow only EC2 SG
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


###### EC2 Instance #####
resource "aws_instance" "web_server" {
  ami           = "ami-0e2c8caa4b6378d8c" 
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name = "WebServer"
  }
  user_data = <<-EOF
              #!/bin/bash
              echo "DB_HOST=${aws_db_instance.default.endpoint}" >> /etc/environment
              echo "DB_USER=maryam" >> /etc/environment
              echo "DB_PASSWORD=maryamabualmagd" >> /etc/environment
              EOF

  # Local Provisioner
  provisioner "local-exec" {
    command = "cmd /c echo ${self.public_ip} > ec2-ip.txt"
  }
}

###### DB #####

resource "aws_db_instance" "default" {
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "maryam"
  password             = "maryamabualmagd"
  parameter_group_name = "default.mysql8.0"
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  skip_final_snapshot  = true
  
 # db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
}
###### DB Subnet group #####
# A DB Subnet Group contains multiple subnets, typically in different Availability Zones within the same VPC.
# When launching an RDS instance, you must associate it with a DB Subnet Group. 
# RDS will then deploy the database instance into one of the subnets in the group.
# 3ashan Multi-AZ Deployments, Private Access, Network Isolation.


# resource "aws_db_subnet_group" "db_subnet_group" {
#   name       = "ivolve-db-subnet-group"
#   subnet_ids = [aws_subnet.private_subnet.id, aws_subnet.public_subnet.id]

#   tags = {
#     Name = "DBSubnetGroup"
#   }
# }
