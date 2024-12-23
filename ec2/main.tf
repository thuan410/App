provider "aws" {
  region = "us-east-1"
}

# Tạo VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "MyVPC"
  }
}

# Tạo Subnet Công khai
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"
}

# Tạo Subnet Riêng tư
resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1a"
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

# Route Table cho Subnet Công khai
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

# Gán Route Table cho Subnet Công khai
resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Security Group cho EC2
resource "aws_security_group" "ec2_sg" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "EC2_Security_Group"
  }
}

# EC2 Instance
resource "aws_instance" "my_ec2" {
  ami           = "ami-003f5a76758516d1e"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public.id
  key_name      = aws_key_pair.my_key.key_name

  user_data = <<-EOF
    #!/bin/bash
    sudo apt update
    sudo apt install -y docker.io nodejs npm
  EOF
  tags = {
    Name = "MyEC2Instance"
  }
}

# tạo key
resource "aws_key_pair" "my_key" {
  key_name   = "key123" # Tên key pair
  public_key = tls_private_key.my_key.public_key_openssh
}

resource "tls_private_key" "my_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

output "private_key" {
  value     = tls_private_key.my_key.private_key_pem
  sensitive = true
}

output "key_name" {
  value = aws_key_pair.my_key.key_name
}