provider "aws" {
  region = "us-east-1"  # Change if needed
}

# Create a Security Group for EC2
resource "aws_security_group" "ec2_sg" {
  name        = "ec2-security-group"
  description = "Security group for EC2 instance"

  # Allow SSH (Only for your IP)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["54.147.165.49/32"]  # Replace with your actual public IP
  }

  # Allow HTTP (Port 80) for Web Access
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create an EC2 Instance
resource "aws_instance" "web_server" {
  ami           = "ami-04b4f1a9cf54c11d0"  # Replace with your region's AMI
  instance_type = "t2.micro"
  security_groups = [aws_security_group.ec2_sg.name]  # Updated Name

  tags = {
    Name = "Om-server"
  }
}

# Output the Public IP of the EC2 Instance
output "instance_public_ip" {
  value = aws_instance.web_server.public_ip
}

