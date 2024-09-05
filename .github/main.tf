# Specify the provider
provider "aws" {
  region = "us-east-1"  # Change this to your preferred AWS region
}

# Define an AWS EC2 instance
resource "aws_instance" "example" {
  ami           = "ami-0e86e20dae9224db8 "  # Replace with your desired AMI ID
  instance_type = "t2.micro"  # Choose an appropriate instance type

  # Optionally add a key pair if you want to SSH into the instance
  key_name = "my-key-pair"  # Ensure you have created a key pair in AWS

  # Tags are optional but useful for organization
  tags = {
    Name = "MyEC2Instance"
  }

  # Security group definition (optional)
  vpc_security_group_ids = [
    aws_security_group.sg.id
  ]

}
# Define a security group to allow SSH access (port 22)
resource "aws_security_group" "sg" {
  name        = "example-security-group"
  description = "Allow SSH inbound traffic"

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

# Optionally define an output to show the public IP of the instance
output "instance_ip" {
  value = aws_instance.example.public_ip
}
